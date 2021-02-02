#!/bin/bash
#
# list.sh list-users
# list.sh list-todos
# list.sh list-user-todos
#
# Usage:
#    list.sh list-users
#    list.sh list-todos Paul
#    list.sh list-user-todos John
#    list.sh list-user-todos "John Doe"
#

DATABASE=tododb
USERNAME=acer
HOSTNAME=localhost
PGPASSWORD=acer

list_users() {
    users="$(psql -qt -h $HOSTNAME -U $USERNAME -d $DATABASE -F $'\n' << EOF
    SELECT * FROM "user"
EOF
)"
    echo $users
}

list_todos() {
    todos="$(psql -qt -h $HOSTNAME -U $USERNAME -d $DATABASE << EOF 
    SELECT * FROM "todo"
EOF
)"
    echo $todos
}

list_user_todos() {
    user_id=$(get_userid $1)
    if [[ "$user_id" != "" ]]
    then
	user_todos="$(psql -h $HOSTNAME -U $USERNAME $DATABASE << EOF
   	SELECT * FROM "todo" WHERE user_id = '$user_id'
EOF
)"
	echo $user_todos
    fi
}

get_userid() {
   userid=$(psql -d tododb -qt  << EOF
   SELECT id FROM "user" WHERE name = '$1'
EOF
)
   echo $userid
}

main() {
    if [[ "$1" == "list-users" ]]
    then
        list_users
    elif [[ "$1" == "list-todos" ]]
    then
        list_todos
    elif [[ "$1" == "list-user-todos" ]]
    then
        list_user_todos "$2"
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
    main "$@"
fi
