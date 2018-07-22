letters = ('a'..'z').to_a
vowels = %w(a e i o u)
vowels_hash = {}
vowels.each do |vowel|
  vowels_hash[vowel] = letters.index(vowel) + 1
end
puts vowels_hash
