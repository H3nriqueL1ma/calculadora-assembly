NAME = program

all: $(NAME).o
	ld -s -o $(NAME) $(NAME).o
	rm -rf *.o

%.o: %.asm
	nasm -f elf64 $<