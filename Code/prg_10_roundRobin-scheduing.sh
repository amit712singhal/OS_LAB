# Print the header for process scheduling simulation
echo -e "\n# Process Scheduling Simulation\n"

echo -e "Amit Singhal - 11614802722 (5C6)\n"

# Read the number of processes
echo -n "Enter number of processes: "
read n

# Read the time quantum for Round Robin scheduling
echo -n "Enter time quantum: "
read tq

# Initialize arrays for burst time, process IDs, temp burst times, turnaround time (TAT), and waiting time (WT)
for ((i = 0; i < n; i++)); do
    echo -n "Enter arrival time & burst time for process P$((i+1)): "
    read arrival[$i] burst[$i]  # Read arrival and burst time for each process
    p[$i]=$i                    # Store process ID
    temp[$i]=${burst[$i]}       # Copy burst time to temp array
    tat[$i]=0                   # Initialize TAT as 0
    wt[$i]=0                    # Initialize WT as 0
done

# Initialize variables for Gantt chart
gantt_process=()                # Gantt chart sequence of processes
gantt_time=()                   # Gantt chart time intervals
time=0                          # Starting time
remain=$n                       # Remaining processes to be executed

# Round Robin scheduling logic
while ((remain != 0)); do
    for ((i = 0; i < n; i++)); do
        if ((temp[i] > 0)); then              # If process still has remaining burst time
            gantt_process+=(${p[$i]})         # Add process to Gantt chart
            gantt_time+=($time)               # Record the current time in Gantt chart

            if ((temp[i] <= tq)); then        # If remaining burst time is less than or equal to time quantum
                time=$((time + temp[i]))      # Add remaining burst time to current time
                tat[$i]=$time                 # Set completion time as turnaround time (TAT)
                wt[$i]=$((time - burst[$i]))  # Calculate waiting time (WT)
                temp[$i]=0                    # Process has finished, set remaining time to 0
                remain=$((remain - 1))        # One less process remaining
            else
                temp[$i]=$((temp[$i] - tq))   # Reduce remaining burst time by time quantum
                time=$((time + tq))           # Add time quantum to current time
            fi
        fi
    done
done
gantt_time+=($time)                           # Record the final time

# Output the process table
echo -e "\n## Process Table\n"
echo -e "| Process | AT | BT | CT | TAT | WT |"
echo -e "|---------|----|----|----|-----|----|"
for ((i = 0; i < n; i++)); do
    ct[$i]=${tat[$i]}                         # Completion time (CT) is the same as turnaround time (TAT)
    echo -e "| P$((i+1))      | ${arrival[$i]}  | ${burst[$i]}  | ${ct[$i]}  | ${tat[$i]}   | ${wt[$i]}  |"
done

# Calculate total and average waiting/turnaround times
total_waiting_time=0
total_turnaround_time=0
for ((i = 0; i < n; i++)); do
    total_waiting_time=$((total_waiting_time + wt[$i]))
    total_turnaround_time=$((total_turnaround_time + tat[$i]))
done
avg_waiting_time=$(echo "scale=2; $total_waiting_time / $n" | bc)
avg_turnaround_time=$(echo "scale=2; $total_turnaround_time / $n" | bc)

# Print total and average times
echo -e "\nTotal Waiting Time: $total_waiting_time"
echo -e "Average Waiting Time: $avg_waiting_time"
echo -e "\nTotal Turnaround Time: $total_turnaround_time"
echo -e "Average Turnaround Time: $avg_turnaround_time"

# Gantt Chart Display
echo -e "\n## Gantt Chart\n"
echo -n "+"
for ((i = 0; i < ${#gantt_process[@]}; i++)); do
    echo -n "----"
done
echo -e "+\n"

for ((i = 0; i < ${#gantt_process[@]}; i++)); do
    echo -n "| P$((gantt_process[$i] + 1)) "
done
echo "|"

echo -n "+"
for ((i = 0; i < ${#gantt_process[@]}; i++)); do
    echo -n "----"
done
echo -e "+"

for ((i = 0; i < ${#gantt_time[@]}; i++)); do
    echo -n "${gantt_time[$i]} "
done
echo -e "\n"
