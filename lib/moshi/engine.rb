require 'moshi/loader'

module Moshi
	class Engine
		VOWEL = /[aeiou]/
		VOWEL_LIST = %w(a e i o u)

		attr_accessor :dictionary

		def initialize filename
			@dictionary = Moshi.load_file(filename)
			puts "Loaded dictionary from #{filename}"
		end

		def suggest(word)
			if @dictionary[word]
				'NO SUGGESTIONS'
			else
				@dictionary[Moshi.mangle(word)]
			end
		end

	private

		def sift(possibles)
			possibles.each_index do |i|
				possibles[i] = @dictionary[possibles[i]]
			end

			possibles.compact
		end

	end
end