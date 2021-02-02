#!/bin/bash
#
# add.sh add-user <user>
# add.sh add-todo <user> <todo>
#
# Usage:
#    add.sh add-user John
#    add.sh add-user Paul
#    add.sh add-todo John Meeting
#    add.sh add-todo Paul "Make breakfast"
#
username=ubuntu
add_user() {
    user=$1
    psql -U $username -d tododb -c "INSERT INTO \"user\" (name) VALUES ('$user')"
    echo "User: $1"
}

add_todo() {
    user_id=$(get_userid $1)
    if [[ "$user_id" != "" ]]
    then
	psql -U $username -d tododb -c "INSERT INTO \"todo\" (task, user_id, done) VALUES('$2', $user_id, 'false')"
    fi
    echo "Todo: $2"
    echo "added new todo"
}

get_userid() {
    userid=$(psql -d tododb -qt << EOF
    SELECT id FROM "user" WHERE name = '$1'
EOF
)
    echo $userid
}

main() {
    if [[ "$1" == "add-user" ]]
    then
        add_user "$2"
    elif [[ "$1" == "add-todo" ]]
    then
        add_todo "$2" "$3"
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
    main "$@"
fi
