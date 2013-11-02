module Moshi
	class Engine
		VOWELS = %w(a e i o u A E I O U)

		attr_reader :dictionary

		def initialize(filename)
			@dictionary = load_dictionary(filename)
		end

		def suggest(subject, options={})
			match_list = @dictionary[Engine.mangle(subject)]
			if match_list.nil?
				return 'NO SUGGESTION'
			elsif match_list.include?(subject)
				return 'CORRECT'
			else
				current_best_score, current_best_match = 99, ''

				match_list.each do |match|
					score = (match.chars - subject.chars).length
					if score < current_best_score && match.length <= subject.length
						current_best_score = score
						current_best_match = match
					end
				end

				unless options[:print_all]
					return current_best_match
				else
					i = match_list.index(current_best_match)
					match_list[0], match_list[i] = match_list[i], match_list[0] unless i == 0
					return match_list
				end
			end
		end

		def generate(count, options={})
			mutants = []
			@dictionary.values.flatten.sample(count).each do |word|
				mutants << word.dup if options[:print_original]
				mutants << Engine.mutate(word)
			end
			return mutants
		end

		def self.mangle(word)
			word.downcase
					.gsub(/([a-z])\1+/) { |s| s[0] }
					.gsub(/[aeiou]+/, '*')
		end

		def self.mutate(word)
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
					key = Engine.mangle(line.chomp)
					list[key] ||= []
					list[key] << line.chomp
				end
			end
			return list
		end

		def self.mutate_vowel(word)
			v = []

			word.each_char.with_index { |c, i| v << i if c =~ /[aeiou]/i }

			i = v.sample
			word[i] = (VOWELS - [word[i]]).sample
			return word
		end

		def self.mutate_dup(word)
			r = rand(1..word.length)
			word.insert(r, word[r-1])
		end

		def self.mutate_case(word)
			r = rand(0...word.length)
			word[r] = word[r].swapcase
			return word
		end

	end
end
