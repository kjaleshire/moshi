module Suggest
	class Engine
		VOWELS = %w(a e i o u)
		VOWEL_RGX = /[aeiou]/i

		def initialize trie
			@word_list = trie
		end

		def suggest(word)
			if @word_list.search(word)
				'No suggestions'
			else
				'No match, would search'
			end
		end

		def generate_fuzzy_vowels(word, suggestions)



		end

	end
end

#@word_list.search(word)