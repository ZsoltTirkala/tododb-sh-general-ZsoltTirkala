check_db(){
  psql -lqt | cut -f 1 | grep -wq tododb
}

if check_db
then
  echo "Tododb exists!"
  dropdb tododb
else
  echo "Tododb does not exist!"
fi

createdb tododb
read -p "Psql username: " username
psql -h localhost -U $username -d tododb -a -f schema.sql
psql -h localhost -U $username -d tododb -a -f data.sql
