module Moshi
	class Engine
		VOWELS = %w(a e i o u A E I O U)

		attr_accessor :dictionary

		def initialize filename
			@dictionary = load_file(filename)
		end

		def suggest(word)
			a = @dictionary[mangle(word)]
			if a.nil? || a.include?(word)
				'NO SUGGESTION'
			else
				a
			end
		end

		def mangle(word)
			# downcase! destroy copycats! destroy vowels!
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
			mutants
		end

		def mutate(word)
			r = rand(1..3)
			loop do
				case r
					when 1
						word = mut_vowel word
					when 2
						word = mut_dup word
					when 3
						word = mut_case word
					when 4
						break
				end
				r = rand(1..4)
			end
			word
		end

	#private

		def load_file(filename, list = {})
			File.open(filename, 'r') do |file|
				file.each_line do |line|
					key = mangle(line.chomp)
					list[key] ||= []
					list[key] << line.chomp
				end
			end
			list
		end

		def mut_vowel(word)
			v = []

			word.each_char.with_index { |c, i| v << i if c =~ /[aeiou]/i }

			i = v.sample
			word[i] = (VOWELS - [word[i]]).sample
			word
		end

		def mut_dup(word)
			r = rand(1..word.length)
			word.insert(r, word[r-1])
		end

		def mut_case(word)
			r = rand(0...word.length)
			letter = word[r]
			case letter
				when /[a-z]/
					word[r] = letter.upcase!
				when /[A-Z]/
					word[r] = letter.downcase!
			end
			word
		end

	end
end