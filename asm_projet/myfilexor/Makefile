CC=gcc
BIN=myfilexor
SRC=$(BIN).S
OBJ=$(BIN).o $(BIN).c


$(BIN): $(BIN).o
	gcc -no-pie $(OBJ) -o $(BIN)

$(BIN).o:
	nasm -f elf64 $(SRC)

clean:
	rm $(BIN).o $(BIN)