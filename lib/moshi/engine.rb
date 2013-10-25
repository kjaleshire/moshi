module Moshi
	class Engine
		VOWEL = /[aeiou]/
		VOWEL_LIST = %w(a e i o u)

		attr_accessor :dictionary

		# Empty Trie indicates we're only using the engine for generation
		def initialize dict=Trie.new
			@dictionary = dict
		end

		def suggest(word)
			if @dictionary.search(word)
				'NO SUGGESTIONS'
			else
				generate_variations()
				suggestions = sift(possibles)
			end
		end

		def generate_variations(word)
			possibles = generate_vowels(word.dup, 0, [])
		end

		def generate_vowels(w, i, possibles)
			index = word.index(VOWEL, i+1)
			return if !index
			a = []
			VOWEL_LIST.each do |v|

				word[index] = v
				a.add(word)
			end
			p a
			a.each do |variation|
				generate_vowels(variation.dup, index, a)
			end
			possibles << a.uniq
		end

		def sift(possibles)
			possibles.each_index do |i|
				possibles[i] = @dictionary.search(possibles[i])
			end

			possibles.compact
		end
	end
end