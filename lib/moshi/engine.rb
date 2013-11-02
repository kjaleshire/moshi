module Moshi
	class Engine
		VOWELS = %w(a e i o u A E I O U)

		attr_accessor :dictionary

		def initialize filename
			@dictionary = load_dictionary(filename)
		end

		def suggest(word, all)
			a = @dictionary[mangle(word)]
			if a.nil?
				return 'NO SUGGESTION'
			elsif a.include?(word)
				return 'CORRECT'
			else
				current_score, current_best = 99, ''

				a.each do |w|
					score = (w.split(//) - word.split(//)).length
					if score < current_score && w.length <= word.length
						current_score = score
						current_best = w
					end
				end

				unless all
					return current_best
				else
					i = a.index(current_best)
					a[0], a[i] = a[i], a[0] unless i == 0
					return a
				end
			end
		end

		def mangle(word)
			word.downcase
					.gsub(/([a-z])\1+/) { |s| s[0] }
					.gsub(/[aeiou]+/, '*')
		end

		def generate(count, original)
			mutants = []
			@dictionary.values.flatten.sample(count).each do |word|
				mutants << word.dup if original
				mutants << mutate(word)
			end
			return mutants
		end

		def mutate(word)
			r = rand(1..3)
			loop do
				case r
					when 1
						word = mutate_vowel word
					when 2
						word = mutate_dup word
					when 3
						word = mutate_case word
					when 4
						break
				end
				r = rand(1..4)
			end
			return word
		end

	private

		def load_dictionary(filename, list = {})
			File.open(filename, 'r') do |file|
				file.each_line do |line|
					key = mangle(line.chomp)
					list[key] ||= []
					list[key] << line.chomp
				end
			end
			return list
		end

		def mutate_vowel(word)
			v = []

			word.each_char.with_index { |c, i| v << i if c =~ /[aeiou]/i }

			i = v.sample
			word[i] = (VOWELS - [word[i]]).sample
			return word
		end

		def mutate_dup(word)
			r = rand(1..word.length)
			word.insert(r, word[r-1])
		end

		def mutate_case(word)
			r = rand(0...word.length)
			word[r] = word[r].swapcase
			return word
		end

	end
end