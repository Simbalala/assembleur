CC=gcc
SRC=fibonnaci.S
OBJ=fibonnaci.o fibonnaci.c
BIN=fibonnaci


$(BIN): $(BIN).o
	gcc -no-pie $(OBJ) -o $(BIN)

$(BIN).o:
	nasm -f elf64 $(SRC)

clean:
	rm $(BIN).o $(BIN)