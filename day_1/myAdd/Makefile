CC=gcc
SRC=myadd.S
OBJ=myadd.o myadd.c
BIN=myadd


$(BIN): $(BIN).o
	gcc -no-pie $(OBJ) -o $(BIN)

$(BIN).o:
	nasm -f elf64 $(SRC)

clean:
	rm $(BIN).o $(BIN)