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

# Allocate memory using First Fit
process_allocated=()
for ((i=0; i<process_count; i++)); do
    allocated=0
    for ((j=0; j<block_count; j++)); do
        if [ ${block_size[$j]} -ge ${process_size[$i]} ] && [ ${block_allocated[$j]} -eq 0 ]; then
            block_allocated[$j]=1  # Mark block as allocated
            process_allocated[$i]=$((j+1))  # Store allocated block index
            allocated=1
            break  # Exit loop once block is allocated
        fi
    done
    if [ $allocated -eq 0 ]; then
        process_allocated[$i]="NA"  # Mark as not allocated if no block found
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
