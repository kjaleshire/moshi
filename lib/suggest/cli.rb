require 'suggest/trie'
require 'suggest/version'
require 'suggest/engine'
require 'suggest/loader'

require 'optparse'

module Suggest
	class CLI
		PROMPT = '> '
		DEFAULT_DICT = '/usr/share/dict/words'

		def initialize argv
			@argv = argv

			Signal.trap("INT") { puts "\nExiting!"; exit 0 }

			build_parser
			parse

			dictionary = Trie.new
			load_dictionary(@options[:filename], dictionary)

			@engine = Engine.new(dictionary)
		end

		def run
			loop do
				print PROMPT
				word = STDIN.gets
				if word
					puts @engine.suggest(word.chomp)
				else
					puts "\nExiting!"; exit 0
				end
			end
		end

		def parse
			@options = {}
			@opt_parser.parse!(@argv)

			@options[:filename] = !@argv.empty? ? @argv.first : DEFAULT_DICT

    	@options
		end

		private

			def build_parser
				@opt_parser = OptionParser.new do |o|
					o.banner = "Usage: suggest [-h|-v] [dictionary_path]"
					o.separator ""
					o.separator "Options:"
					o.separator "dictionary_path\tpath to dictionary file"

					o.on_tail "-h", "--help", "Show help" do
	        	puts @opt_parser
	        	exit 1
	      	end

	      	o.on_tail("-v", "--version", "Show version") do
		        puts File.read('VERSION')
		        exit
		      end
				end
			end

			def load_dictionary filename, dictionary
				puts "Loading dictionary at #{filename}..."
				begin_time = Time.now

				Suggest.load_words(filename, dictionary)

				puts "Loaded dictionary in #{Time.now - begin_time} seconds"
			end


		#end private
	end
end