echo "Amit Singhal - 11614802722 (5C6)"

# Prompt user to enter the window size
echo -n "Enter the window size: "
read window_size                       # Read the window size (i.e., number of frames)

# Prompt user to enter the reference string
echo -n "Enter the reference string: "
read -a ref_string                     # Read reference string as an array

# Initialize empty array for frames (memory slots) and page fault counter
frames=()
page_faults=0                          # Initialize page fault counter

# Iterate through each page in the reference string
for page in "${ref_string[@]}"
do
    # Check if the page is not already in the frames (using a string comparison for array content)
    if [[ ! " ${frames[@]} " =~ " $page " ]]; then
        # If there's space in the frames (less than the window size), add the page directly
        if [ ${#frames[@]} -lt $window_size ]; then
            frames+=($page)            # Append new page to frames
        else
            # If the frames are full, remove the oldest (first) page and add the new one
            frames=("${frames[@]:1}")  # Remove the first (oldest) element from frames
            frames+=($page)            # Append new page to frames
        fi
        ((page_faults++))              # Increment the page fault count when a page replacement happens
    fi
done

# Output the number of page faults encountered
echo "Page Faults By FIFO: $page_faults"
