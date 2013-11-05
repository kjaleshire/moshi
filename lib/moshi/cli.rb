require 'moshi/version'
require 'moshi/engine'

require 'moshi/hash/slice'

require 'optparse'

module Moshi
	class CLI
		DEFAULT_DICT = '/usr/share/dict/words'
		PROMPT = '> '

		def initialize(argv=[])

			catch_interrupt

			@opt_parser = build_parser
			@opt_parser.parse! argv

			@engine = Moshi::Engine.new(@options[:filename])
		end

		def run
			if @options[:generate]
				mutants = @engine.generate @options[:generate], @options.slice(:print_original)

				puts mutants
			else

				loop do
					print PROMPT
					word = STDIN.gets
					if word
						puts word if @options[:print_original]
						puts @engine.suggest(word.chomp, @options.slice(:print_all))
					else # on no input received (end-of-file or ctrl-D)
						exit 0
					end
				end

			end
		end

	private

		def catch_interrupt
		  Signal.trap('INT') { exit 0 }
		end

		def build_parser
			@options = { filename: DEFAULT_DICT }

			OptionParser.new do |o|
				o.banner = "Usage: moshi [options]"
				o.separator ""
				o.separator "Options:"

				o.on "-d DICTIONARY", "--dictionary DICTIONARY", "Path to dictionary file" do |d|
					@options[:filename] = d
				end

				o.on "-g N", "--generate N", Integer, "Generate N mispellings" do |n|
					@options[:generate] = n
				end

				o.on "-a", "--all", "Print all suggestions, not just the best" do
					@options[:print_all] = true
				end

				o.on "-o", "--original", "Print the original word before suggestion or generation" do |n|
					@options[:print_original] = true
				end

				o.on_tail "-h", "--help", "Show help" do
        	puts @opt_parser
        	exit 1
      	end

      	o.on_tail "-v", "--version", "Show version" do
	        puts Moshi::VERSION
	        exit 1
	      end
			end
		end

	end
end