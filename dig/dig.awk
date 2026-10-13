BEGIN {
  FS = ",";
  max_member_number = 1;
  PROCINFO["sorted_in"] = "@ind_num_desc";
}

# Return true if call looks like a valid callsign.
function valid_call(call)
{
  return call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]{1,4}[A-Z]{1,3}$/ && call !~ /^DE/;
}

# Return true for entries that should be silently ignored
# rather than reported as unrecognized callsigns.
function silly_call(call)
{
  return call ~ /SWL|-|_|^DE|[0-9]$|^[A-Z]$|CALL/;
}

# Correct known errors/special cases in the source data.
function fix_bad_call(call)
{
  call = toupper(call);
  if (call == "S560R") call = "S56OR";
  if (call == "DL6ES(Y43)") call = "DL6ES";
  if (call == "VIA_DF4UM") call = "DF4UM";
  return call;
}

# Read relevant member records.
$3 ~ /^[0-9]{4}$/ && $2 ~ /J/ {
  member_calls[$3] = $4;
  member_other_calls[$3] = $5;
}

END {
  # Build primary and secondary callsign tables.
  for (member_number in member_calls)
  {
    primary_call = member_calls[member_number];

    if (!valid_call(primary_call))
    {
      if (!silly_call(primary_call))
        printf("Ignored primary call: \"%s\"\n", primary_call) > "/dev/stderr";
      continue;
    }

    if (primary_call in primary_member)
      printf("%s reappears\n", primary_call) > "/dev/stderr";

    primary_member[primary_call] = member_number;

    if (int(member_number) > int(max_member_number))
      max_member_number = member_number;

    if (member_other_calls[member_number] == "")
      continue;

    call_count = split(toupper(member_other_calls[member_number]), call_list, " ");

    for (i = 1; i <= call_count; i++)
    {
      secondary_call = fix_bad_call(call_list[i]);

      if (valid_call(secondary_call))
      {
        secondary_calls[primary_call][secondary_call] = 1;

        # Remember which primary call first claimed this secondary callsign.
        if (!(secondary_call in secondary_owner))
          secondary_owner[secondary_call] = primary_call;
      }
      else if (!silly_call(secondary_call))
      {
        printf("Ignored other call: \"%s\"\n", secondary_call) > "/dev/stderr";
      }
    }
  }

  # Output callsign database.

  secondary_call_count = 0;

  for (primary_call in primary_member)
  {
    member_number = primary_member[primary_call];

    printf("%s=%s\n", primary_call, member_number);

    for (secondary_call in secondary_calls[primary_call])
    {
      # A secondary call must not also be another member's primary call.
      if (secondary_call in primary_member)
      {
        printf("Secondary call %s for %s already member #%s's primary call\n",
               secondary_call, primary_call, primary_member[secondary_call]) > "/dev/stderr";
      }

      # A secondary call must not belong to more than one member.
      else if (secondary_owner[secondary_call] != primary_call)
      {
        other_primary_call = secondary_owner[secondary_call];

        printf("Secondary call %s for %s already member #%s's secondary call\n",
               secondary_call, primary_call, primary_member[other_primary_call]) > "/dev/stderr";
      }
      else
      {
      # The secondary call is unique, so output it.
        printf("%s=%s\n", secondary_call, member_number);
        secondary_call_count++;
      }
    }
  }

  printf("%d primary calls\n", length(primary_member)) > "/dev/stderr";
  printf("%d secondary calls\n", secondary_call_count) > "/dev/stderr";
  printf("Highest member number is %d\n", max_member_number) > "/dev/stderr";

  printf("#00 DIG members prefill database\n");
  printf("#01 Based on official member roster at https://diplom-interessen-gruppe.info \n");
  printf("#03 Contains members up to #%d\n", max_member_number);
  printf("#04 Last updated %s\n", strftime("%Y-%m-%d"));
}