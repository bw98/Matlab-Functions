#include <cstdio>
#define maxn 101
int num;//number of bus or fol
int graph[maxn*maxn][maxn*maxn];
int state[maxn][maxn];
 
//when cross river
int c_bus[5] = {2, 1, 0, 1, 0};
int c_fol[5] = {0, 1, 2, 0, 1};
int b_step[maxn*maxn];
int f_step[maxn*maxn];
 
bool flag = false;
void DFS(int bus, int fol, int step, int dir)
{
    b_step[step] = bus, f_step[step] = fol;
    if(bus == 0 && fol == 0)
    {
        for(int i = 0; i <= step; i++)
        {
            printf("(%d,%d)", b_step[i], f_step[i]);
            if(i != step )
                printf(" -> ");
        }
        printf("\n");
        flag = true;
    }
    int fa = bus * ( num + 1 ) + fol;
    for(int i = 0; i < 5; i++)
    {
        if(dir)
        {
            int b_next = bus - c_bus[i], f_next = fol - c_fol[i];
            if(b_next >= 0 && b_next < num+1 && f_next >= 0 && f_next < num + 1 && state[b_next][f_next])
            {
                int son = b_next * ( num + 1 ) + f_next;
                if(!graph[fa][son] && !graph[son][fa])
                {
                    graph[fa][son] = 1;
                    graph[son][fa] = 1;
                    DFS(b_next, f_next, step + 1, !dir);
                    graph[fa][son] = 0;
                    graph[fa][son] = 0;
                }
            }
        }
        else
        {
            int b_next = bus + c_bus[i], f_next = fol + c_fol[i];
            if(b_next >= 0 && b_next < num + 1 && f_next >= 0 && f_next < num + 1 && state[b_next][f_next])
            {
                int son = b_next * ( num + 1) + f_next;
                if(!graph[fa][son] && !graph[son][fa])
                {
                    graph[fa][son] = 1;
                    graph[son][fa] = 1;
                    DFS(b_next, f_next, step + 1, !dir);
                    graph[fa][son] = 0;
                    graph[fa][son] = 0;
                }
            }
        }
    }
}
int main()
{
    printf("Please input the number of the businessman: ");
    scanf("%d",&num);
    for(int i = 0; i < num + 1; i++)
    {
        state[i][0] = 1;
        state[i][num] = 1;
        state[i][i] = 1;
    }
    DFS(num, num, 0, 1);
    if(!flag)
        printf("they can't cross the river.");
}
