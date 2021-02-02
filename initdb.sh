check_db(){
  psql -lqt | cut -f 1 | grep -wq $1
}

echo database:
read
if check_db $REPLY
then
  echo $REPLY exists
else
  echo $REPLY does not exist
fi


check_db
