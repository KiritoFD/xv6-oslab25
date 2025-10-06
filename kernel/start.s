```
/*
 * This file is part of the XV6 operating system.
 * XV6 is a simple Unix-like teaching operating system.
 * It is used in MIT's Operating Systems Engineering course.
 *
 * The code is in the public domain.
 */

/*
 * File: start.s
 * Purpose: Boot the XV6 kernel
 */

#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

extern int main(void);
void _start(void) {
  // 学号: 21302010057
  // 函数作用: 初始化栈和段寄存器，跳转到main函数启动内核

  // Set up the stack and segment registers
  asm volatile(
    "movl $0x20, %%eax\n"
    "movw %%ax, %%ds\n"
    "movw %%ax, %%es\n"
    "movw %%ax, %%fs\n"
    "movw %%ax, %%gs\n"
    "movl $0, %%ebp\n"
    "movl $0, %%esp\n"
    "jmp main\n"
    :
    :
    : "%eax", "memory"
  );
}

/*
 * File: sleep.c
 * Purpose: Sleep for a specified number of ticks
 */

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(2, "Usage: sleep <ticks>\n");
        exit(1);
    }
    int ticks = atoi(argv[1]);
    sleep(ticks);
    printf("(nothing happens for a little while)\n");
    exit(0);
}
```