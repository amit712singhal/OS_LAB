echo "Amit Singhal - 11614802722 (5C6)"

P=5
R=3

available=(3 3 2)

max=(
"7 5 3"
"3 2 2"
"9 0 2"
"2 2 2"
"4 3 3"
)

allocation=(
"0 1 0"
"2 0 0"
"3 0 2"
"2 1 1"
"0 0 2"
)

declare -A need

# Calculate the Need matrix
for ((i=0; i<$P; i++)); do
  for ((j=0; j<$R; j++)); do
    max_value=(${max[i]})
    allocation_value=(${allocation[i]})
    need[$i,$j]=$(( ${max_value[$j]} - ${allocation_value[$j]} ))
  done
done

# Function to print matrices
function print_matrices {
  echo "Available resources: ${available[@]}"

  echo -e "\nMax matrix:"
  for ((i=0; i<$P; i++)); do
    echo "Process $i: ${max[i]}"
  done

  echo -e "\nAllocation matrix:"
  for ((i=0; i<$P; i++)); do
    echo "Process $i: ${allocation[i]}"
  done

  echo -e "\nNeed matrix:"
  for ((i=0; i<$P; i++)); do
    echo -n "Process $i: "
    for ((j=0; j<$R; j++)); do
      echo -n "${need[$i,$j]} "
    done
    echo ""
  done
}

# Function to check if the request is less than or equal to available resources
function is_less_or_equal {
  local process=$1
  for ((i=0; i<$R; i++)); do
    if [ ${need[$process,$i]} -gt ${available[$i]} ]; then
      return 1
    fi
  done
  return 0
}

# Safety algorithm to find if there exists a safe sequence
function safety_algorithm {
  local work=("${available[@]}")
  local finish=()
  local safe_sequence=()

  # Initialize finish array to false for all processes
  for ((i=0; i<$P; i++)); do
    finish[$i]=0
  done

  echo -e "\nRunning the Banker's Algorithm to find a safe sequence..."

  while true; do
    local found=false
    for ((i=0; i<$P; i++)); do
      if [ ${finish[$i]} -eq 0 ]; then
        is_less_or_equal $i
        if [ $? -eq 0 ]; then
          for ((j=0; j<$R; j++)); do
            work[$j]=$(( ${work[$j]} + ${allocation[$i,$j]} ))
          done
          safe_sequence+=($i)
          finish[$i]=1
          found=true
        fi
      fi
    done
    if [ "$found" == false ]; then
      break
    fi
  done

  # Check if all processes are finished
  for ((i=0; i<$P; i++)); do
    if [ ${finish[$i]} -eq 0 ]; then
      echo "The system is in an unsafe state!"
      return 1
    fi
  done

  echo "The system is in a safe state!"
  echo "Safe Sequence: ${safe_sequence[@]}"
  return 0
}

# Print matrices
print_matrices

# Run the safety algorithm
safety_algorithm
