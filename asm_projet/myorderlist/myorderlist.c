#include <stdio.h>

char* orderlist(long long *list, int size);

int write_list(char *s);

long long li[] = {0x200, 0x3, 0x8};

int main() {
    char* value = orderlist(li, 3);
    // printf("return %s\n", value);
    // printf("%s\n", orderlist(li, 3));
    // print: "3, 8, 16\n"

    return 0;
}





