echo "Amit Singhal - 11614802722 (5C6)"

# Prompt user to enter the window size (number of frames)
echo -n "Enter the window size: "
read window_size

# Prompt user to enter the reference string (space-separated values)
echo -n "Enter the reference string (space-separated): "
read -a ref_string

# Initialize frames and page fault counter
frames=()
page_faults=0

# Iterate through each page in the reference string
for ((i=0; i<${#ref_string[@]}; i++)); do
    page=${ref_string[i]}  # Current page
    # Check if the page is already in the frames
    if [[ ! " ${frames[@]} " =~ " $page " ]]; then
        # If frames are not full, simply add the page
        if [ ${#frames[@]} -lt $window_size ]; then
            frames+=($page)
        else
            # Find the optimal page to replace
            farthest=-1
            replace_index=0
            for ((j=0; j<${#frames[@]}; j++)); do
                found=0
                for ((k=i+1; k<${#ref_string[@]}; k++)); do
                    if [ ${frames[j]} -eq ${ref_string[k]} ]; then
                        if [ $k -gt $farthest ]; then
                            farthest=$k
                            replace_index=$j
                        fi
                        found=1
                        break
                    fi
                done
                if [ $found -eq 0 ]; then
                    replace_index=$j
                    break
                fi
            done
            frames[$replace_index]=$page
        fi
        ((page_faults++))  # Increment page faults
    fi
done

# Output the total page faults
echo "Page Faults By Optimal: $page_faults"
