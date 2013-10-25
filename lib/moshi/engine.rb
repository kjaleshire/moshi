module Moshi
	class Engine
		VOWEL = /[aeiou]/
		VOWEL_LIST = %w(a e i o u)

		attr_accessor :dictionary

		def initialize filename
			@dictionary = Moshi.load_words(filename)
		end

		def suggest(word)
			if @dictionary.search(word)
				'NO SUGGESTIONS'
			else
				# TODO
				possibles = ["Suggestions possible"]
				suggestions = sift(possibles)
			end
		end

	private

		def sift(possibles)
			possibles.each_index do |i|
				possibles[i] = @dictionary.search(possibles[i])
			end

			possibles.compact
		end

	end
end