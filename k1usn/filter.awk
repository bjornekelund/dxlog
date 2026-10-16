function find_column(field_name)
{
  for (i = 2; i <= 5; i++)
    if ($i ~ field_name)
      return i - 1;

  printf("Problem !!Order!! line: \"%s\"\n", $0) > "/dev/stderr";
  return 0;
}

function valid_name(value)
{
  return value ~ /^([A-Z][A-Za-z]+)?$/;
}

function valid_us_exchange(value)
{
  return value ~ /^(AL|AK|AZ|AR|CA|CO|CT|DE|DC|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|ND|NE|NV|NH|NJ|NM|NY|NC|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|CWA|)$/;
}

function valid_us_territory_exchange(value)
{
  return value ~ /^(DX|AL|AK|AZ|AR|CA|CO|CT|DE|DC|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|ND|NE|NV|NH|NJ|NM|NY|NC|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|PR|VI|CWA|)$/;
}

function valid_canadian_exchange(value)
{
  return value ~ /^(AB|BC|LB|MB|NB|NF|NS|NT|NU|ON|PE|QC|SK|YT|CWA|)$/;
}

function us_territory_call(value)
{
  return value ~ /^KG4[A-Z]{2}$|^[KNW]P[234][A-Z]{1,3}$/ &&
         value !~ /\/V[EOY][0-9]$/;
}

BEGIN {
  printf("#00 K1USN Slow Speed Test prefill database\n");
  FS = ",";
  longest_name = "";
}

{
  bad = 0;
  duplicate = 0;

  if ($0 ~ /^(!|#|$)/)
  {
    if ($1 ~ /!!Order!!/)
    {
      call_column = find_column("Call");
      name_column = find_column("Name");
      exchange_column = find_column("Exch1");

      # printf("%s --> call=%d name=%d exchange=%d\n",
      #        $0, call_column, name_column, exchange_column) > "/dev/stderr";
    }
  }
  else if ($call_column ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/)
  {
    call = $call_column;
    operator_name = $name_column;
    operator_exchange = $exchange_column;

    if (line[$1] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", line[$call_column], $0) > "/dev/stderr";
      duplicate = 1;
    }
    else if (!valid_name(operator_name))
    {
      printf("Problem name: \"%s\"\n", $0) > "/dev/stderr";
      bad = 1;
    }
    else if (IsCONUScall(call))
    {
      if (!valid_us_exchange(operator_exchange))
      {
        printf("Problem US exchange: \"%s\"\n", $0) > "/dev/stderr";
        bad = 1;
      }
    }
    else if (us_territory_call(call))
    {
      if (!valid_us_territory_exchange(operator_exchange))
      {
        printf("Problem KP[234] exchange: \"%s\"\n", $0) > "/dev/stderr";
        bad = 1;
      }
    }
    else if (IsVEcall(call))
    {
      if (!valid_canadian_exchange(operator_exchange))
      {
        printf("Problem Canadian exchange: \"%s\"\n", $0) > "/dev/stderr";
        bad = 1;
      }
    }
    else if (operator_exchange != "" && operator_exchange != "DX")
    {
      # printf("Exchange should be DX: \"%s\"\n", $0) > "/dev/stderr";
      bad = 1;
    }

    if (!bad)
    {
      line[$1] = $0;
      calls[$1] = call;

      if (operator_name != "")
        name[$1] = toupper(operator_name);

      if (operator_exchange != "")
        exchange[$1] = operator_exchange;

      if (length(operator_name) > length(longest_name))
        longest_name = operator_name;
    }
    else if (!duplicate)
    {
      printf("Problem line: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
  else
  {
    printf("Problem call: \"%s\"\n", $0) > "/dev/stderr";
  }
}

END {
  printf("Longest name is \"%s\" with %d characters\n",
         longest_name, length(longest_name)) > "/dev/stderr";

  printf("#04 Longest name is \"%s\" with %d characters\n",
         longest_name, length(longest_name));

  for (key in calls)
  {
    if (name[key] != "")
      printf("%s=%s;%s\n", calls[key], name[key], exchange[key]);
  }
}