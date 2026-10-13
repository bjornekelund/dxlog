function predicted_id(call,    i)
{
  for (i = 1; i <= rule_count; i++)
    if (call ~ rule_regex[i])
      return rule_id[i];

  return "";
}

function add_rule(regex, id)
{
  rule_regex[++rule_count] = regex;
  rule_id[rule_count] = id;
}

function known_exchange_exception(call, oid)
{
  return \
    (call == "VE1ASE" && oid == "NB") ||
    (call == "VE1EJ"  && oid == "ON") ||
    (call == "ZF2DO"  && oid == "TX") ||
    (call == "ZF2LZ"  && oid == "MA");
}

function valid_id(id)
{
  return id ~ /^(|[1-9][0-9]{0,3}|CWA|[IGF]|3DA|9M[26]|VP2M|[0-9][A-Z]|[A-Z]{1,2}[0-9]?)$/;
}

function valid_name(name)
{
  return name ~ /^[A-Za-z]+$/;
}

function valid_call(call)
{
  return call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]{1,2}[A-Z]{1,4}(\/[A-Z0-9]+)?$/;
}

BEGIN {
  FS = ",";

  max_member = 0;
  longest_name = "";

  add_rule("^3B9", "3B9");
  add_rule("^3DA", "3DA");
  add_rule("^4O", "4O");
  add_rule("^4[X-Z]", "4Z");
  add_rule("^5T", "5T");
  add_rule("^6Y", "6Y");
  add_rule("^8P", "8P");
  add_rule("^9A", "9A");
  add_rule("^9M6", "9M6");
  add_rule("^(7[X-Z]|HZ)", "HZ");
  add_rule("^9H", "9H");
  add_rule("^B[ADY]", "BY");
  add_rule("^(CE|X[QR])", "CE");
  add_rule("^C6", "C6");
  add_rule("^CO", "CM");
  add_rule("^C[R-T]", "CT");
  add_rule("^CU", "CU");
  add_rule("^D[A-R]", "DL");
  add_rule("^E2", "HS");
  add_rule("^E7", "E7");
  add_rule("^E[A-F]6", "EA6");
  add_rule("^E[A-F]8", "EA8");
  add_rule("^E[A-F]9", "EA9");
  add_rule("^E[A-F][0123457]", "EA");
  add_rule("^E[I-J]", "EI");
  add_rule("^ER", "ER");
  add_rule("^ES", "ES");
  add_rule("^E[U-W]", "EU");
  add_rule("^EX", "EX");
  add_rule("^EY", "EY");
  add_rule("^F[0-9]|^F\\/", "F");
  add_rule("^([GM][0-9KR]|2E)", "G");
  add_rule("^[GM]D", "GD");
  add_rule("^[GM]M", "GM");
  add_rule("^[GM]W", "GW");
  add_rule("^[GM]U", "GU");
  add_rule("^[GM]I", "GI");
  add_rule("^[GM]J", "GJ");
  add_rule("^H[AG]", "HA");
  add_rule("^HB[1-9]", "HB");
  add_rule("^HC", "HC");
  add_rule("^HK", "HK");
  add_rule("^(HL|DS)", "HL");
  add_rule("^HR", "HR");
  add_rule("^I[0-9,K-N,T-Z\\/]", "I");
  add_rule("^IS0", "IS0");
  add_rule("^(J[A-S]|7L)", "JA");
  add_rule("^JT", "JT");
  add_rule("^[KNW]P2", "VI");
  add_rule("^[KNW]P4", "PR");
  add_rule("^L[A-N]", "LA");
  add_rule("^L[O-W]", "LU");
  add_rule("^LX", "LX");
  add_rule("^LY", "LY");
  add_rule("^LZ", "LZ");
  add_rule("^OD", "OD");
  add_rule("^OE", "OE");
  add_rule("^O[G-J]", "OH");
  add_rule("^O[KL]", "OK");
  add_rule("^OM", "OM");
  add_rule("^O[N-T]", "ON");
  add_rule("^O[U-Z]", "OZ");
  add_rule("^P4", "P4");
  add_rule("^P[A-I]", "PA");
  add_rule("^PJ7", "PJ7");
  add_rule("^P[P-Y]", "PY");
  add_rule("^PZ", "PZ");
  add_rule("^(R[089][A-Z]|R[A-Z][089]|UA[089])", "UA9");
  add_rule("^(R[1-7][A-Z]|R[A-Z][1-9]|UA[1-7])", "UA");
  add_rule("^S5", "S5");
  add_rule("^(S[A-M]|[78]S)", "SM");
  add_rule("^(S[N-R]|3Z|HF)", "SP");
  add_rule("^ST", "ST");
  add_rule("^S[V-Z][01234678]", "SV");
  add_rule("^S[V-Z]5", "SV5");
  add_rule("^S[V-Z]9", "SV9");
  add_rule("^(T6|YA)", "YA");
  add_rule("^T[ABC]", "TA");
  add_rule("^TF", "TF");
  add_rule("^TG", "TG");
  add_rule("^TI", "TI");
  add_rule("^TY", "TY");
  add_rule("^UN", "UN");
  add_rule("^U[R-Z]", "UR");
  add_rule("^V3", "V3");
  add_rule("^V3", "V3");

  # Canada
  add_rule("^((V[A-GX]|C[FG])1|CY[09])[A-Z]{1,3}$|(V[A-GX]|C[FG]).+\\/1$|\\/VE1$", "NS");
  add_rule("^(V[A-GX]|X[LM]|C[FG])2[A-Z]{1,3}$|(V[A-GX]|C[FG]).+\\/2$|\\/VE2$", "QC");
  add_rule("^(V[A-GX]|X[LM]|C[FG])3[A-Z]{1,3}$|(V[A-GX]|C[FG]).+\\/3$|\\/VE3$", "ON");
  add_rule("^(V[A-GX]|C[FG])4[A-Z]{1,3}$|(V[A-GX]|C[FG]).+\\/4$|\\/VE4$", "MB");
  add_rule("^(V[A-GX]|C[FG])5[A-Z]{1,3}$|(V[A-GX]|C[FG]).+\\/5$|\\/VE5$", "SK");
  add_rule("^(V[A-GX]|C[FG])6[A-Z]{1,3}$|(V[A-GX]|C[FG]).+\\/6$|\\/VE6$", "AB");
  add_rule("^(V[A-GX]|C[FG])7[A-Z]{1,3}$|(V[A-GX]|C[FG]).+\\/7$|\\/VE7$", "BC");
  add_rule("^(VE|C[FG])8[A-Z]{1,3}$|(V[A-GX]|C[FG]).+\\/8$\\/VE8$", "NT");
  add_rule("^(V[CE]|C[FG])9[A-Z]{1,3}$|(V[A-GX]|C[FG]).+\\/9$|\\/VE9$", "NB");
  add_rule("^VO[12][A-Z]{1,3}$|\\/VO[12]$", "NL");
  add_rule("^VY0[A-Z]{1,3}$|\\/VY0$", "NU");
  add_rule("^(VY|XO)1[A-Z]{1,3}$|\\/VY1$", "YT");
  add_rule("^VY2[A-Z]{1,3}$|\\/VY2$", "PE");

  # North America etc.
  add_rule("^VK[1-8]", "VK");
  add_rule("^VP2M", "VP2M");
  add_rule("^VP9|\\/VP9$", "VP2M");
  add_rule("^VU", "VU");
  add_rule("^XE", "XE");
  add_rule("^YL", "YL");
  add_rule("^Y[BCDE]", "YB");
  add_rule("^Y[OPQ]", "YO");
  add_rule("^Y[TU]", "YU");
  add_rule("^ZA", "ZA");
  add_rule("^ZB", "ZB");
  add_rule("^Z3", "Z3");
  add_rule("^ZD7", "ZD7");
  add_rule("^ZD8", "ZD8");
  add_rule("^ZF", "ZF");
  add_rule("^Z[KLM]", "ZL");
  add_rule("^ZP", "ZP");
  add_rule("^Z[R-S]", "ZS");
}

{
  call = toupper($1);
  name = $2;
  original_id = toupper($3);
  id = "";

  if (valid_call(call) && (name != "" || original_id != "") && lines[call] == "") 
  {
    id = predicted_id(call);

    if (id != "" && original_id != "" && id != original_id && 
        original_id !~ /^([1-9][0-9]{0,3}|CWA)$/ && 
        !known_exchange_exception(call, original_id)) 
    {
      printf("Exchange is \"%s\" for %s but should probably be \"%s\"\n", original_id, call, id) > "/dev/stderr";
    }

    # An exchange in the source file takes precedence over the predicted one.
    if (original_id != "") id = original_id;
    else if (id == "" && call != "N4DL") 
    {
      # printf("Empty member/location for %s\n", call) > "/dev/stderr";
    }

    id_is_valid = valid_id(id);
    id_problem = !id_is_valid && !(id == "" && call ~ /^(N|K|W|V[A-G])/);

    name_is_valid = valid_name(name);

    if (!name_is_valid && name != "") 
    {
      printf("Problem name ignored: \"%s\"\n", $0) > "/dev/stderr";
      name = "";
    }

    if ((!name_is_valid && !id_is_valid) || id_problem || (!name_is_valid && id !~ /^([0-9]+|[A-Z]{2})$/)) 
    {

      printf("namevalid=%d idvalid=%d ID=%s\n", name_is_valid, id_is_valid, id) > "/dev/stderr";
      printf("Ignored1: \"%s\"\n", $0) > "/dev/stderr";
    }
    else 
    {
      printf("%s=%s;%s\n", call, name, id);

      if (int(id) > max_member)
        max_member = int(id);

      if (length(name) > length(longest_name))
        longest_name = name;

      lines[call] = $0;
    }
  }
  else if ($0 !~ /^(#|!|$)/ && !(name == "" && id == "")) 
  {
    if (lines[call] != "")
      printf("Callsign reoccurrence: \"%s\"\n", $0) > "/dev/stderr";
    else
      printf("Ignored2: \"%s\"\n", $0) > "/dev/stderr";
  }
}

END {
  printf("#00 CWOps CWT prefill database\n");
  printf("Highest member number is %d\n", max_member) > "/dev/stderr";
  printf("Longest name is \"%s\" with %d characters\n", longest_name, length(longest_name)) > "/dev/stderr";
  printf("#04 Longest name is \"%s\" with %d characters\n", longest_name, length(longest_name));
  printf("#05 Contains members up to #%d\n", max_member);
}