echo "Amit Singhal - 11614802722 (5C6)"

# Input the number of memory blocks
echo -n "Enter the number of memory blocks: "
read block_count

# Input the sizes of the memory blocks
echo -n "Enter size of blocks: "
read -a block_size

# Initialize block allocation status
block_allocated=()
for ((i=0; i<block_count; i++)); do
    block_allocated[$i]=0
done

# Input the number of processes
echo -n "Enter the number of processes: "
read process_count

# Input the sizes of the processes
echo -n "Enter size of processes: "
read -a process_size

# Allocate memory using Best Fit
process_allocated=()
for ((i=0; i<process_count; i++)); do
    best_fit_index=-1
    for ((j=0; j<block_count; j++)); do
        if [ ${block_size[$j]} -ge ${process_size[$i]} ] && [ ${block_allocated[$j]} -eq 0 ]; then
            if [ $best_fit_index -eq -1 ] || [ ${block_size[$best_fit_index]} -gt ${block_size[$j]} ]; then
                best_fit_index=$j  # Update best fit index
            fi
        fi
    done
    if [ $best_fit_index -ne -1 ]; then
        block_allocated[$best_fit_index]=1  # Mark block as allocated
        process_allocated[$i]=$((best_fit_index+1))  # Store allocated block index
    else
        process_allocated[$i]="NA"  # Mark as not allocated
    fi
done

# Display the output in tabular format
echo -e "\n+-------------+--------------+-----------+"
echo -e "| Process No. | Process Size | Block no. |"
echo -e "+-------------+--------------+-----------+"
for ((i=0; i<process_count; i++)); do
    printf "| %-11s | %-12s | %-9s |\n" "$((i+1))" "${process_size[$i]}" "${process_allocated[$i]}"
done
echo -e "+-------------+--------------+-----------+"
