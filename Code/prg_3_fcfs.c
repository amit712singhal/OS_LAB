#include <stdio.h>
#include <stdlib.h>
#define MAX 100

typedef struct
{
  int pid;
  int burst_time;
  int waiting_time;
  int turnaround_time;
} Process;

void print_table(Process p[], int n);
void print_gantt_chart(Process p[], int n);

int main()
{
  Process p[MAX];
  int i, j, n;
  int sum_waiting_time = 0, sum_turnaround_time = 0;

  printf("\n5C6 - Amit Singhal (11614802722) \n");

  printf("\nEnter total number of processes: ");
  scanf("%d", &n);

  printf("\nEnter burst time for each process:\n");
  for (i = 0; i < n; i++)
  {
    p[i].pid = i + 1;
    printf("P[%d]: ", i + 1);
    scanf("%d", &p[i].burst_time);
    p[i].waiting_time = 0;
    p[i].turnaround_time = 0;
  }

  p[0].turnaround_time = p[0].burst_time;
  for (i = 1; i < n; i++)
  {
    p[i].waiting_time = p[i - 1].waiting_time + p[i - 1].burst_time;
    p[i].turnaround_time = p[i].waiting_time + p[i].burst_time;
  }

  for (i = 0; i < n; i++)
  {
    sum_waiting_time += p[i].waiting_time;
    sum_turnaround_time += p[i].turnaround_time;
  }

  puts("");
  print_table(p, n);
  printf("\nTotal Waiting Time: %d\n", sum_waiting_time);
  printf("Average Waiting Time: %.2lf\n", (double)sum_waiting_time / (double)n);
  printf("Total Turnaround Time: %d\n", sum_turnaround_time);
  printf("Average Turnaround Time: %.2lf\n", (double)sum_turnaround_time / (double)n);

  puts("\nGANTT CHART\n");
  print_gantt_chart(p, n);

  return 0;
}

void print_table(Process p[], int n)
{
  int i;

  puts("+-----+------------+--------------+-----------------+");
  puts("| PID | Burst Time | Waiting Time | Turnaround Time |");
  puts("+-----+------------+--------------+-----------------+");

  for (i = 0; i < n; i++)
  {
    printf("| %3d | %10d | %12d | %15d |\n", p[i].pid, p[i].burst_time, p[i].waiting_time, p[i].turnaround_time);
    puts("+-----+------------+--------------+-----------------+");
  }
}

void print_gantt_chart(Process p[], int n)
{
  int i, j;

  // Top border of the Gantt chart
  puts("+----+----+----+----+----+----+");

  // Process IDs
  puts("| P1 | P2 | P3 | P4 | P5 | P6 |");

  // Bottom border of the Gantt chart
  puts("+----+----+----+----+----+----+");

  for (i = 0; i < n; i++)
  {
    printf("| %d  ", p[i].turnaround_time);
    if (p[i].turnaround_time > 9)
      printf("\b"); // Remove 1 space if the number has 2 digits
  }
  printf("|\n");
  puts("+----+----+----+----+----+----+");
  printf("\n");
}
