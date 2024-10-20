#!/bin/bash

echo $'\n' "5C6 - Amit Singhal (11614802722)" $'\n'

read -p "Enter the number of processes: " num_processes
echo $'\n' "Enter Arrival Time & Burst Time for $num_processes processes"

# Collect process details
for ((i=0;i<num_processes;i++)); do
    echo -n "P$((i+1)): "
    read arrival_time burst_time
    processes[$i]="$arrival_time $burst_time"
    remaining_burst[$i]=$burst_time  # Track the remaining burst time for preemption
    process_completed[$i]=0          # Track if the process is completed
done

# Initialize variables
total_completion_time=0
total_waiting_time=0
total_turnaround_time=0
gantt_chart="0"  # Start Gantt chart at time 0
time=0           # Global time
completed_processes=0
prev_process=-1  # Track the previously executing process for Gantt chart

# Function to find the process with the shortest remaining burst time among those that have arrived
find_shortest_remaining() {
    local min_burst=-1
    local min_index=-1

    for ((i=0;i<num_processes;i++)); do
        current_process=(${processes[$i]})
        current_arrival_time=${current_process[0]}

        if (( process_completed[$i] == 0 && current_arrival_time <= time )); then
            if (( min_burst == -1 || remaining_burst[$i] < min_burst )); then
                min_burst=${remaining_burst[$i]}
                min_index=$i
            fi
        fi
    done

    echo $min_index
}

# Display table header
echo -e "\nProcess\t Arrival Time\t Burst Time\t Completion Time\t Turnaround Time\t Waiting Time"

# Process all processes using SRTF (Preemptive SJF)
while (( completed_processes < num_processes )); do
    shortest_job=$(find_shortest_remaining)

    if (( shortest_job == -1 )); then
        # No process available, increase time (idle)
        gantt_chart+=" -- XX -- $((++time))"
    else
        current_process=(${processes[$shortest_job]})
        current_arrival_time=${current_process[0]}
        current_burst_time=${current_process[1]}

        # If a new process is selected or time has changed
        if (( prev_process != shortest_job )); then
            if (( prev_process != -1 )); then
                gantt_chart+=" -- $time"
            fi
            gantt_chart+=" -- P$((shortest_job+1))"
            prev_process=$shortest_job
        fi

        # Execute the shortest job for one unit of time
        remaining_burst[$shortest_job]=$((remaining_burst[$shortest_job] - 1))
        time=$((time + 1))

        # If the process is completed, update its stats
        if (( remaining_burst[$shortest_job] == 0 )); then
            completion_time=$time
            turnaround_time=$((completion_time - current_arrival_time))
            waiting_time=$((turnaround_time - current_burst_time))

            # Update total values
            total_completion_time=$completion_time
            total_waiting_time=$((total_waiting_time + waiting_time))
            total_turnaround_time=$((total_turnaround_time + turnaround_time))

            # Mark the process as completed
            process_completed[$shortest_job]=1
            completed_processes=$((completed_processes + 1))

            # Display process details
            echo -e "P$((shortest_job+1))\t\t$current_arrival_time\t\t$current_burst_time\t\t$completion_time\t\t\t$turnaround_time\t\t\t$waiting_time"
        fi
    fi
done

# End Gantt chart with the last completion time
gantt_chart+=" -- $time"

# Calculate averages
avg_waiting_time=$(awk "BEGIN {printf \"%.2f\", $total_waiting_time/$num_processes}")
avg_turnaround_time=$(awk "BEGIN {printf \"%.2f\", $total_turnaround_time/$num_processes}")

# Display Gantt chart
echo -e "\nGantt Chart:"
echo -e "$gantt_chart"

# Display averages
echo ""
echo "Avg waiting time: $avg_waiting_time"
echo "Avg turnaround time: $avg_turnaround_time"
