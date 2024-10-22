# Alyssa Ballestro
# 10/11/2024
# Programming Languages

# Sort values then merge the sorted array
def sort(left, right)
  sorter = []
  until left.empty? || right.empty?
    if left.first <= right.first
      sorter << left.shift
    else
      sorter << right.shift
    end
  end
  # Append remaining elements from left or right
  sorter + left + right
end

# Recursive mergesort function
def mergesort(arr)
  # Arrays of length 0-1 are already sorted
  return arr if arr.length <= 1

  # Split the array into two halves
  mid = arr.length / 2
  left = mergesort(arr[0...mid])
  right = mergesort(arr[mid...arr.length])

  # Sort & merge the halves
  sort(left, right)
end

# Function to get user input
def get_user_input
  puts "Enter real numbers to sort (enter -1 to finish):"
  arr = []

  while true
    input = gets.chomp.to_i # (gets) a copy of the user input (chomp) and makes it an integer (to_i)
    break if input == -1
    arr << input
  end

  arr
end

# Main function for the program
# Main function for the program
def main
  while true
    user_array = get_user_input
    break if user_array.empty? # Exit if no input

    sorted_array = mergesort(user_array)
    puts "Sorted Array Complete: #{sorted_array}"

    puts "Would you like to sort another array? (yes/no)"
    continue = gets.chomp.downcase
    break if continue != "yes"
  end
end


# Runs the program
main