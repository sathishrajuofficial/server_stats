#!/bin/bash

# Function to print the current date and time
print_date() {
    echo -e "\nDate and Time: $(date)"
}

# Function to get total CPU usage
get_cpu_usage() {
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    echo -e "\nTotal CPU Usage: ${cpu_usage}%"
}

# Function to get total memory usage
get_memory_usage() {
    mem_total=$(free -h | grep Mem: | awk '{print $2}')
    mem_used=$(free -h | grep Mem: | awk '{print $3}')
    mem_free=$(free -h | grep Mem: | awk '{print $4}')
    mem_percentage=$(free | grep Mem: | awk '{print $3/$2 * 100.0}')
    
    echo -e "\nTotal Memory Usage:"
    echo -e "Total Memory: $mem_total"
    echo -e "Used Memory: $mem_used"
    echo -e "Free Memory: $mem_free"
    echo -e "Memory Usage: ${mem_percentage}%"
}

# Function to get total disk usage
get_disk_usage() {
    disk_usage=$(df -h --total | grep total | awk '{print $3 "/" $2 " (" $5 " used)"}')
    echo -e "\nTotal Disk Usage: $disk_usage"
}

# Function to get top 5 processes by CPU usage
get_top_cpu_processes() {
    echo -e "\nTop 5 Processes by CPU Usage:"
    ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
}

# Function to get top 5 processes by Memory usage
get_top_memory_processes() {
    echo -e "\nTop 5 Processes by Memory Usage:"
    ps -eo pid,comm,%mem --sort=-%mem | head -n 6
}

# Main function to display stats
main() {
    print_date
    get_cpu_usage
    get_memory_usage
    get_disk_usage
    get_top_cpu_processes
    get_top_memory_processes
}

# Execute the main function
main
