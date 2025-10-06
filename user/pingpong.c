#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argc, char *argv[]) {
    int f2c[2], c2f[2];
    pipe(f2c);
    pipe(c2f);
    
    if (fork() == 0) {
        // 子进程
        close(f2c[1]); // 关闭父写端
        close(c2f[0]); // 关闭子读端
        int father_pid;
        read(f2c[0], &father_pid, sizeof(int));
        printf("%d: received ping from pid %d\n", getpid(), father_pid);
        int child_pid = getpid();
        write(c2f[1], &child_pid, sizeof(int));
        close(f2c[0]);
        close(c2f[1]);
    } else {
        // 父进程
        close(f2c[0]); // 关闭父读端
        close(c2f[1]); // 关闭子写端
        int father_pid = getpid();
        write(f2c[1], &father_pid, sizeof(int));
        int child_pid;
        read(c2f[0], &child_pid, sizeof(int));
        printf("%d: received pong from pid %d\n", getpid(), child_pid);
        close(f2c[1]);
        close(c2f[0]);
    }
    exit(0);
}
