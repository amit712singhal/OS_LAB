echo "Amit Singhal - 11614802722 (5C6)"

# Prompt user to enter the window size (number of frames)
echo -n "Enter the window size: "
read window_size

# Prompt user to enter the reference string (space-separated values)
echo -n "Enter the reference string (space-separated): "
read -a ref_string

# Initialize frames, usage times, and page fault counter
frames=()
usage=()
page_faults=0

# Iterate through each page in the reference string
for ((i=0; i<${#ref_string[@]}; i++)); do
    page=${ref_string[i]}  # Current page
    found=0
    # Check if the page is already in the frames
    for ((j=0; j<${#frames[@]}; j++)); do
        if [ ${frames[j]} -eq $page ]; then
            found=1
            usage[j]=$i  # Update the usage time for this page
            break
        fi
    done

    if [ $found -eq 0 ]; then
        # If frames are not full, add the page and update usage time
        if [ ${#frames[@]} -lt $window_size ]; then
            frames+=($page)
            usage+=($i)
        else
            # Find the Least Recently Used page by checking usage times
            lru_index=0
            min_usage=${usage[0]}
            for ((j=1; j<${#usage[@]}; j++)); do
                if [ ${usage[j]} -lt $min_usage ]; then
                    min_usage=${usage[j]}
                    lru_index=$j
                fi
            done
            # Replace the LRU page with the current page
            frames[$lru_index]=$page
            usage[$lru_index]=$i  # Update usage time
        fi
        ((page_faults++))  # Increment page fault counter
    fi
done

# Output the total page faults
echo "Page Faults By LRU: $page_faults"
