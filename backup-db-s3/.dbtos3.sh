#!/bin/bash
# Basic variables
mysqlpass="Gr0c3r^^@x"
bucket="s3://dbgmx1"
# Timestamp (sortable AND readable)
stamp=`date +"%d-%B-%Y-@-%H%M"`
# List all the databases
databases=`mysql -u root -p$mysqlpass -h localhost -e "SHOW DATABASES;" | tr -d "| " | grep -v "\(Database\|information_schema\|performance_schema\|mysql\|test\|phpmyadmin\)"`
# Feedback
echo -e "Dumping to \e[1;32m$bucket/$stamp/\e[00m"
# Loop the databases
for db in $databases; do

  # Define our filenames
  filename="$stamp-$db.sql.gz"
  tmpfile="/tmp/$filename"
  object="$bucket/$filename"

  # Feedback
  echo -e "\e[1;34m$db\e[00m"

  # Dump and zip
  echo -e "  creating \e[0;35m$tmpfile\e[00m"
  mysqldump -u root -p$mysqlpass --force --opt --databases "$db" | gzip -c > "$tmpfile"

  # Upload
  echo -e "  uploading..."
  s3cmd put "$tmpfile" "$object"

  # Delete
  echo -e "  removing...$tmpfile"
  rm -f "$tmpfile"

done;
