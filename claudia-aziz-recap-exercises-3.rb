require "byebug"
# Write a method no_dupes?(arr) that accepts an array as an arg and returns a new array containing the elements that were not repeated in the array.
def no_dupes?(arr)
    count = Hash.new(0)
    arr.each { |ele| count[ele] += 1 }
    count.select { |k,v| v < 2 }.keys
end
# Examples
# p no_dupes?([1, 1, 2, 1, 3, 2, 4])         # => [3, 4]
# p no_dupes?(['x', 'x', 'y', 'z', 'z'])     # => ['y']
# p no_dupes?([true, true, true])            # => []

# Write a method no_consecutive_repeats?(arr) that accepts an array as an arg. The method should return true if an element never appears consecutively in the array; it should return false otherwise.
def no_consecutive_repeats?(arr)
    (0...arr.length-1).each do |i|
        return false if arr[i] == arr[i + 1]
    end
    true
end
# Examples
# p no_consecutive_repeats?(['cat', 'dog', 'mouse', 'dog'])     # => true
# p no_consecutive_repeats?(['cat', 'dog', 'dog', 'mouse'])     # => false
# p no_consecutive_repeats?([10, 42, 3, 7, 10, 3])              # => true
# p no_consecutive_repeats?([10, 42, 3, 3, 10, 3])              # => false
# p no_consecutive_repeats?(['x'])                              # => true

# Write a method char_indices(str) that takes in a string as an arg. The method should return a hash containing characters as keys. The value associated with each key should be an array containing the indices where that character is found.
def char_indices(str)
    indices = Hash.new { |h,k| h[k] = [] }
    str.each_char.with_index { |char, i| indices[char] << i  }
    indices
end
# Examples
# p char_indices('mississippi')   # => {"m"=>[0], "i"=>[1, 4, 7, 10], "s"=>[2, 3, 5, 6], "p"=>[8, 9]}
# p char_indices('classroom')     # => {"c"=>[0], "l"=>[1], "a"=>[2], "s"=>[3, 4], "r"=>[5], "o"=>[6, 7], "m"=>[8]}

# Write a method longest_streak(str) that accepts a string as an arg. The method should return the longest streak of consecutive characters in the string. If there are any ties, return the streak that occurs later in the string.
def longest_streak(str)
    longest = ""
    current = ""

    (0...str.length).each do |i|
        if str[i] == str[i - 1] || i == 0
            current += str[i]
        else
            current = str[i]
        end
        longest = current if current.length >= longest.length
    end

    longest
end
# Examples
# p longest_streak('a')           # => 'a'
# p longest_streak('accccbbb')    # => 'cccc'
# p longest_streak('aaaxyyyyyzz') # => 'yyyyy
# p longest_streak('aaabbb')      # => 'bbb'
# p longest_streak('abc')         # => 'c'

# Write a method bi_prime?(num) that accepts a number as an arg and returns a boolean indicating whether or not the number is a bi-prime. A bi-prime is a positive integer that can be obtained by multiplying two prime numbers.

def prime?(n)
    return false if n < 2
    (2...n).none? { |i| n % i == 0 }
end

def bi_prime?(num)
    (2...num).each do |num_1|
        (2...num).each do |num_2|
            return true if num_1 * num_2 == num && prime?(num_1) && prime?(num_2)
        end
    end
    false
end
# For Example:
# 14 is a bi-prime because 2 * 7
# 22 is a bi-prime because 2 * 11
# 25 is a bi-prime because 5 * 5
# 24 is not a bi-prime because no two prime numbers have a product of 24
# Examples
# p bi_prime?(14)   # => true
# p bi_prime?(22)   # => true
# p bi_prime?(25)   # => true
# p bi_prime?(94)   # => true
# p bi_prime?(24)   # => false
# p bi_prime?(64)   # => false

# A Caesar cipher takes a word and encrypts it by offsetting each letter in the word by a fixed number, called the key. Given a key of 3, for example: a -> d, p -> s, and y -> b.

# A Vigenere Cipher is a Caesar cipher, but instead of a single key, a sequence of keys is used. For example, if you encrypt "bananasinpajamas" with the key sequence [1, 2, 3], then the result would be "ccqbpdtkqqcmbodt":

# # Message:  b a n a n a s i n p a j a m a s
# # Keys:     1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1
# # Result:   c c q b p d t k q q c m b o d t
# Write a method vigenere_cipher(message, keys) that accepts a string and a key-sequence as args, returning the encrypted message. Assume that the message consists entirely of lowercase alphabetic characters.

def vigenere_cipher(message, keys)
    new_msg = ""
    alpha = ("a".."z").to_a
    message.each_char.with_index do |char, i|
        old_idx = alpha.index(char)
        new_idx = (old_idx + keys[i % keys.length]) % 26
        new_msg += alpha[new_idx]
    end
    new_msg
end

# Examples
# p vigenere_cipher("toerrishuman", [1])        # => "upfssjtivnbo"
# p vigenere_cipher("toerrishuman", [1, 2])     # => "uqftsktjvobp"
# p vigenere_cipher("toerrishuman", [1, 2, 3])  # => "uqhstltjxncq"
# p vigenere_cipher("zebra", [3, 0])            # => "ceerd"
# p vigenere_cipher("yawn", [5, 1])             # => "dbbo"

# Write a method vowel_rotate(str) that accepts a string as an arg and returns the string where every vowel is replaced with the vowel that appears before it sequentially in the original string. The first vowel of the string should be replaced with the last vowel.
def vowel_indices(str)
    (0...str.length).select { |i| "aeiou".include?(str[i]) }
end

def vowel_rotate(str)
    indices = vowel_indices(str)
    new_str = ""

    (0...str.length).each do |i|
        if indices.include?(i)
            idx = indices.index(i)
            if indices[0] == i
                new_str += str[indices[-1]]
            else
                new_str += str[indices[idx - 1]]
            end
        else
            new_str += str[i]
        end
    end

    new_str
end
# Examples
# p vowel_rotate('computer')      # => "cempotur"
# p vowel_rotate('oranges')       # => "erongas"
# p vowel_rotate('headphones')    # => "heedphanos"
# p vowel_rotate('bootcamp')      # => "baotcomp"
# p vowel_rotate('awesome')       # => "ewasemo"

# Extend the String class by defining a String#select method that accepts a block. The method should return a new string containing characters of the original string that return true when passed into the block. If no block is passed, then return the empty string. Do NOT use the built-in Array#select in your solution.
class String
    def select(&prc)
        return "" if !prc
        selected = ""
        self.each_char { |char| selected += char if prc.call(char) }
        selected
    end
end
# Examples
# p "app academy".select { |ch| !"aeiou".include?(ch) }   # => "pp cdmy"
# p "HELLOworld".select { |ch| ch == ch.upcase }          # => "HELLO"
# p "HELLOworld".select          # => ""

# Extend the String class by defining a String#map! method that accepts a block. The method should modify the existing string by replacing every character with the result of calling the block, passing in the original character and it's index. Do NOT use the built-in Array#map or Array#map! in your solution.
class String
    def map!(&prc)
        self.each_char.with_index do |char, i|
        self[i] = prc.call(char, i)
        end
    end
end
# Examples
# word_1 = "Lovelace"
# word_1.map! do |ch| 
#     if ch == 'e'
#         '3'
#     elsif ch == 'a'
#         '4'
#     else
#         ch
#     end
# end
# p word_1        # => "Lov3l4c3"

# word_2 = "Dijkstra"
# word_2.map! do |ch, i|
#     if i.even?
#         ch.upcase
#     else
#         ch.downcase
#     end
# end
# p word_2        # => "DiJkStRa"

# Write a method multiply(a, b) that takes in two numbers and returns their product.
# You must solve this recursively (no loops!)
# You must NOT use the multiplication (*) operator
def multiply(a, b)
    return 0 if a == 0 || b == 0
    if a == 1
        return b
    elsif b == 1
        return a 
    end

    return a + multiply(a, b - 1)
end
# Examples
p multiply(3, 5)        # => 15
p multiply(5, 3)        # => 15
p multiply(2, 4)        # => 8
p multiply(0, 10)       # => 0
# p multiply(-3, -6)      # => 18
# p multiply(3, -6)       # => -18
# p multiply(-3, 6)       # => -18