#include <stdio.h>

int orderlist(long long *list, int size);

int write_list(char *s);

long long li[] = {0x200, 0x3, 0x8};

int main() {
    int value = orderlist(li, 3);
    printf("return %d\n", value);
    // printf("%s\n", orderlist(li, 3));
    // print: "3, 8, 16\n"

    return 0;
}





