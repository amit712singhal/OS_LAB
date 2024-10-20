echo "Amit Singhal - 11614802722 (5C6)"

# Parameters
buffer_size=5
buffer=()
count=0
sem_empty=$buffer_size
sem_full=0
mutex=1
iterations=20 # Set number of iterations to run

# Functions to produce and consume items
produce_item() { echo $((RANDOM % 100)) }
consume_item() { echo "Consumed item: $1" }

# Producer function
producer() {
    for ((i = 0; i < iterations; i++)); do
        item=$(produce_item)
        echo "Producing item: $item"

        # Wait until there's space in the buffer
        while [[ $sem_empty -eq 0 ]]; do
            sleep 1 # Wait
        done

        # Enter critical section
        ((mutex--))
        buffer+=("$item")
        ((count++))
        ((sem_empty--))
        ((sem_full++))
        echo "Buffer: ${buffer[@]}"
        ((mutex++))
        sleep 1 # Simulate time taken to produce
    done
}

# Consumer function
consumer() {
    for ((i = 0; i < iterations; i++)); do
        # Wait until there's at least one item to consume
        while [[ $sem_full -eq 0 ]]; do
            sleep 1 # Wait
        done

        # Enter critical section
        ((mutex--))
        item=${buffer[0]}
        buffer=("${buffer[@]:1}") # Remove the first item
        ((count--))
        ((sem_full--))
        ((sem_empty++))
        echo "Buffer: ${buffer[@]}"
        consume_item "$item"
        ((mutex++))
        sleep 1 # Simulate time taken to consume
    done
}

# Start producer and consumer in the background
producer & # Start producer in background
consumer & # Start consumer in background

# Wait for the processes to finish
wait
