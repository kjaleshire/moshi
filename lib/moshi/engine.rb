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
				'NO SUGGESTION'
			elsif match_list.include?(subject)
				'CORRECT'
			else
				get_best_match(match_list, subject, options)
			end
		end

		def generate(count, options={})
			mutants = []
			sample_dictionary(count).each do |word|
				mutants << word if options[:print_original]
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
			mutation = nil
			loop do
				case rand(1..4)
					when 1
						mutation = mutate_vowel(mutation || word)
					when 2
						mutation = mutate_dup(mutation || word)
					when 3
						mutation = mutate_case(mutation || word)
					when 4
						break if mutation
				end
			end
			return mutation
		end

	private

		def load_dictionary(filename, list={})
			File.open(filename) do |file|
				file.each_line do |line|
					key = Engine.mangle(line.chomp)
					list[key] ||= []
					list[key] << line.chomp
				end
			end
			return list
		end

		def best_match_list(match_list, current_best_match)
			i = match_list.index(current_best_match)
			match_list[0], match_list[i] = match_list[i], match_list[0] unless i == 0
			return match_list
		end

		def sample_dictionary(count)
			@dictionary.values.flatten.sample(count)
		end

		def get_best_match(match_list, subject, options={})
			par, best_match = 99, ''

			match_list.each do |match|
				score = (match.chars - subject.chars).length
				if score < par && match.length <= subject.length
					par, best_match = score, match
				end
			end

			return best_match unless options[:print_all]

			return best_match_list(match_list, best_match)

		end

		def self.mutate_vowel(word)
			v = []

			word.each_char.with_index { |c, i| v << i if c =~ /[aeiou]/i }

			i = v.sample
			if i
				word[i] = (VOWELS - [word[i]]).sample
				return word
			else
				return nil
			end
		end

		def self.mutate_dup(word)
			r = rand(0...word.length)
			word.insert(r+1, word[r])
		end

		def self.mutate_case(word)
			r = rand(0...word.length)
			word[r] = word[r].swapcase
			return word
		end

	end
end
