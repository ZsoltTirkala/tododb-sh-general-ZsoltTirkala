check_db(){
  psql -lqt | cut -f 1 | grep -wq tododb
}

if check_db
then
  echo tododb exists
  dropdb tododb
else
  echo tododb does not exist
fi

createdb tododb
echo psq username:
read
psql -h localhost -U $REPLY -d tododb -a -f schema.sql
psql -h localhost -U $REPLY -d tododb -a -f data.sql
