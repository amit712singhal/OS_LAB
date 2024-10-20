#include <stdio.h>

typedef struct
{
  int pid;        // Process ID
  int arrival;    // Arrival time
  int burst;      // Burst time
  int completion; // Completion time
  int waiting;    // Waiting time
  int turnaround; // Turnaround time
} Process;

// Function to sort processes by arrival time, and by burst time in case of tie
void sortByArrival(Process *p, int n)
{
  for (int i = 0; i < n - 1; i++)
  {
    for (int j = 0; j < n - i - 1; j++)
    {
      if (p[j].arrival > p[j + 1].arrival ||
          (p[j].arrival == p[j + 1].arrival && p[j].burst > p[j + 1].burst))
      {
        Process temp = p[j];
        p[j] = p[j + 1];
        p[j + 1] = temp;
      }
    }
  }
}

// Main SJF logic
void sjfScheduling(Process *p, int n)
{
  int time = 0, completed = 0, minIndex;

  while (completed < n)
  {
    minIndex = -1;

    // Find process with min burst time from the pool of arrived processes
    for (int i = 0; i < n; i++)
    {
      if (p[i].arrival <= time && p[i].completion == 0)
      {
        if (minIndex == -1 || p[i].burst < p[minIndex].burst)
        {
          minIndex = i;
        }
      }
    }

    if (minIndex != -1)
    {
      if (time < p[minIndex].arrival)
        time = p[minIndex].arrival; // Set time to the process arrival time if idle

      time += p[minIndex].burst;
      p[minIndex].completion = time;
      p[minIndex].turnaround = p[minIndex].completion - p[minIndex].arrival;
      p[minIndex].waiting = p[minIndex].turnaround - p[minIndex].burst;
      completed++;
    }
    else
    {
      time++;
    }
  }
}

// Function to display the Gantt chart with idle times
void displayGanttChart(Process *p, int n)
{
  int currentTime = p[0].arrival; // Start from the first process arrival time
  printf("Gantt Chart:\n");

  // Print initial time
  printf("%d", currentTime);

  for (int i = 0; i < n; i++)
  {
    if (currentTime < p[i].arrival)
    {
      // Display idle time
      printf(" -- XX -- %d", p[i].arrival);
      currentTime = p[i].arrival; // Update current time to the arrival of the next process
    }
    // Display the process and its completion time
    printf(" -- P%d -- %d", p[i].pid, p[i].completion);
    currentTime = p[i].completion; // Update current time to the completion of the current process
  }

  printf("\n\n");
}

// Function to calculate and display average times
void calculateAverages(Process *p, int n)
{
  float totalTurnaround = 0, totalWaiting = 0;

  for (int i = 0; i < n; i++)
  {
    totalTurnaround += p[i].turnaround;
    totalWaiting += p[i].waiting;
  }

  printf("\nAverage Turnaround Time: %.2f\n", totalTurnaround / n);
  printf("Average Waiting Time: %.2f\n", totalWaiting / n);
}

// Function to display process information
void displayResults(Process *p, int n)
{
  printf("PID\tArrival\t Burst\t Completion\tTurnaround\tWaiting\n");
  for (int i = 0; i < n; i++)
  {
    printf("%d\t%d\t %d\t %d\t\t%d\t\t%d\n", p[i].pid, p[i].arrival, p[i].burst,
           p[i].completion, p[i].turnaround, p[i].waiting);
  }
}

int main()
{
  int n;
  printf("\n5C6 - Amit Singhal (11614802722)\n");
  printf("\nEnter number of processes: ");
  scanf("%d", &n);
  Process p[n];

  for (int i = 0; i < n; i++)
  {
    printf("\nEnter Arrival Time and Burst Time for Process %d: ", i + 1);
    p[i].pid = i + 1;
    scanf("%d%d", &p[i].arrival, &p[i].burst);
    p[i].completion = 0; // Initially, no process is completed
  }
  printf("\n");

  sortByArrival(p, n);
  sjfScheduling(p, n);
  displayGanttChart(p, n);
  displayResults(p, n);
  calculateAverages(p, n);

  printf("\n");

  return 0;
}
