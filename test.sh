gcc -Wall -Werror -Wextra -L. main.c -lasm
if test $? -eq 0 ;then
	./a.out $1 &
	sleep 1
	leaks $! | grep -E "leaks? for"
	kill $!
fi
