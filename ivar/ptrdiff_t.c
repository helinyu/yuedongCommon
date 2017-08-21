#include<stdio.h>
#include<stddef.h>
#include<string.h>
int main(int argc,char *argv[])
{
    char str[] = "Hello world!";
    char *pstart = str;
    char *pend = str + strlen(str);
    ptrdiff_t difp = pend - pstart;
    printf("%d\n", difp);
    return 0;
}
