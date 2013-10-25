require 'suggest/trie'
require 'suggest/version'
require 'suggest/engine'

module Suggest
	class CLI
		PROMPT = '> '

		def initialize args=[]
			@args = args
			Signal.trap("INT") { puts "\nExiting!"; exit 0 }
			@word_list = Trie.new
			@engine = Engine.new @word_list
			@word_array = []
			load_words
		end

		def run
			loop do
				print PROMPT
				word = STDIN.gets.chomp
				puts @engine.suggest(word)
			end
		end

		private

			def load_words
				filename = @args[0] || '/usr/share/dict/words'
				puts "Loading dictionary at #{filename}..."
				begin_time = Time.now

				begin
					file = File.open(filename)
					file.each_line do |line|
						#@word_list.store(line.chomp)
						@word_array << line.chomp
					end
				rescue Exception => e
					puts e
					exit 1
				ensure
					file.close unless file.nil?
				end

				end_time = Time.now
				puts "Loaded dictionary in #{end_time - begin_time} seconds"
			end

		#end private
	end
end