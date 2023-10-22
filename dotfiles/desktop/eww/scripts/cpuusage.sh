# output=$(top -bn1)
# echo "Top output:"
# echo "$output"
# filtered_output=$(echo "$output" | grep 'Cpu\(s\)')
# echo "Filtered output:"
# echo "$filtered_output"
echo $(top -bn1 | grep "Cpu" | awk '{print $2 + $4}')
