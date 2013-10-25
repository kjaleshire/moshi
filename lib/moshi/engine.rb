module Moshi
	class Engine
		VOWEL = /[aeiou]/
		VOWEL_LIST = %w(a e i o u)

		attr_accessor :dictionary

		def initialize filename
			@dictionary = load_file(filename)
			puts "Loaded dictionary from #{filename}"
		end

		def suggest(word)
			@dictionary[::Engine.mangle(word)] || 'NO SUGGESTION'
		end

		def self.mangle(word)
			# lowercase it!
			word.downcase!

			# destroy copycat letters!
			word.gsub!(/([a-z])\1+/) { |s| s[0] }

			# destroy all vowels!
			word.gsub!(/[aeiou]+/, '*')

			word
		end

#	private

		def load_file(filename, list = {})
			begin
				file = File.open(filename)
				file.each_line do |line|
					key = ::Engine.mangle(line.chomp!.dup)
					list[key] ||= []
					list[key] << line
				end
			rescue Exception => e
				puts e
				exit 1
			ensure
				file.close unless file.nil?
			end
			list
		end

	end
end