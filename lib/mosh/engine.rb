module Mosh
	class Engine
		VOWELS = %w(a e i o u)
		VOWEL_RGX = /[aeiou]/i

		attr_accessor :dictionary

		def initialize trie
			@dictionary = trie
		end

		def suggest(word)
			if @dictionary.search(word)
				'No suggestions'
			else
				'No match, would search'
			end
		end

		def generate_fuzzy_vowels(word, suggestions)



		end
	end
end