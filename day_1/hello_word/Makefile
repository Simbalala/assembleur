CC=gcc
SRC=myhello.S
BIN=myhello


$(BIN): $(BIN).o
	gcc -no-pie $(BIN).o -o $(BIN)

$(BIN).o:
	nasm -f elf64 $(SRC)

clean:
	rm $(BIN).o $(BIN)