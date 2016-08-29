#!/bin/bash
# Basic variables
bucket="s3://dbgmx1"
# Timestamp (sortable AND readable)
stamp=`date +"%d-%B-%Y-@-%H%M"`
# List all the databases owned by odoo user
databases=`psql -l | awk '{print $1 " " $3}' | grep odoo | awk '{print $1}'`
# Feedback
echo -e "Dumping to \e[1;32m$bucket/$stamp/\e[00m"
# Database backup
for db in $databases; do

  # Define our filenames
  filename="$stamp-$db.sql.gz"
  tmpfile="/tmp/$filename"
  object="$bucket/odoo/$filename"

  # Feedback
  echo -e "\e[1;34m$db\e[00m"

  # Dump and zip
  echo -e "  creating \e[0;35m$tmpfile\e[00m"
  pg_dump $db | gzip -c > $tmpfile
  # Upload
  echo -e "  uploading..."
  s3cmd put "$tmpfile" "$object"

  # Delete
  echo -e "  removing...$tmpfile"
  rm -f "$tmpfile"

done;
