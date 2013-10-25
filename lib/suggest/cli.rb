require 'suggest/trie'
require 'suggest/version'
require 'suggest/engine'
require 'suggest/loader'

require 'optparse'

module Suggest
	class CLI
		PROMPT = '> '

		def initialize args=[]
			Signal.trap("INT") { puts "\nExiting!"; exit 0 }

			@word_list = Trie.new
			@engine = Engine.new(@word_list)

			filename = args[0] || '/usr/share/dict/words'

			puts "Loading dictionary at #{filename}..."
			begin_time = Time.now
			Suggest.load_words(filename, @word_list)
			end_time = Time.now
			puts "Loaded dictionary in #{end_time - begin_time} seconds"
		end

		def run
			loop do
				print PROMPT
				word = STDIN.gets.chomp
				puts @engine.suggest(word)
			end
		end

	end
end