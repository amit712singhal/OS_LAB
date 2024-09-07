echo $'\n' "5C6 - Amit Singhal (11614802722)" $'\n'

read -p "Enter the number of processes: " num_processes

# Collect process details
for ((i=0;i<num_processes;i++)); do
    echo ""
    read -p "Enter the arrival time for process $((i+1)): " arrival_time
    read -p "Enter the burst time for process $((i+1)): " burst_time
    processes[$i]="$arrival_time $burst_time"
done

# Sort processes by arrival time
IFS=$'\n' sorted_processes=($(sort -n -k1 <<<"${processes[*]}"))
unset IFS

# Initialize variables
total_completion_time=0
total_waiting_time=0
total_turnaround_time=0

# Display table header
echo -e "\nProcess\t Burst Time\tArrival Time\tWaiting Time\t Turnaround Time\tCompletion Time"

# Process all processes
for ((i=0;i<num_processes;i++)); do
    current_process=(${sorted_processes[$i]})
    current_arrival_time=${current_process[0]}
    current_burst_time=${current_process[1]}

    # Calculate waiting time
    if (( i == 0 )); then
        waiting_time=0
    else
        waiting_time=$((total_completion_time - current_arrival_time))
        if ((waiting_time < 0)); then
            waiting_time=0
        fi
    fi

    # Calculate completion time and turnaround time
    completion_time=$((total_completion_time + current_burst_time))
    turnaround_time=$((completion_time - current_arrival_time))

    # Update total values
    total_completion_time=$completion_time
    total_waiting_time=$((total_waiting_time + waiting_time))
    total_turnaround_time=$((total_turnaround_time + turnaround_time))

    # Display process details
    echo -e "P$((i+1))\t $current_burst_time\t\t$current_arrival_time\t\t$waiting_time\t\t $turnaround_time\t\t  \t$completion_time"
done

# Calculate averages
avg_waiting_time=$(awk "BEGIN {printf \"%.2f\", $total_waiting_time/$num_processes}")
avg_turnaround_time=$(awk "BEGIN {printf \"%.2f\", $total_turnaround_time/$num_processes}")

# Display averages
echo ""
echo "Avg waiting time: $avg_waiting_time"
echo "Avg turnaround time: $avg_turnaround_time"
