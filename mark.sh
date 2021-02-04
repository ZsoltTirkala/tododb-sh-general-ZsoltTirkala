#!/bin/bash
#
# mark.sh mark-todo <todo-id>
# mark.sh unmark-todo <todo-id>
#
# Usage:
#    mark.sh mark-todo 32
#    mark.sh unmark-todo 32
#

mark_todo(){
psql -d tododb -c <<EOF "UPDATE todo SET done = 'true' WHERE id =$1"
EOF
echo "Todo marked as done"
}
unmark_todo(){
psql -d tododb -c <<EOF "UPDATE todo SET done = 'false' WHERE id =$1"
EOF
echo "Todo marked as *not* done"
}
main(){
if [[ "$1" == "mark-todo" ]]
then
	mark_todo "$2"
elif [[ "$1" == "unmark-todo" ]]
then
	unmark_todo "$2"
fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
    main "$@"
fi
