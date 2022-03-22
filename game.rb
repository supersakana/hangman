# frozen_string_literal: true

word_file = File.open('google-10000-english-no-swears.txt')

words = word_file.readlines.map(&:chomp)

puts words
