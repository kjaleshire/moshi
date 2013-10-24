require 'suggest/trie'

module Suggest
	class CLI
		def initialize
			@word_store = Suggest::Trie.new
			run
		end

		def run
			loop do
				puts "> "
				word = gets.chomp
				puts suggest(word)
			end
		end

		private

			def suggest(word)
				p word
			end

			def vowel_distance(word)

			end

			def case_distance(word)

			end

			def repeat_distance(word)

			end

		#end private
	end
end