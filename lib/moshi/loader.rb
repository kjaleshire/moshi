module Moshi
	def Moshi.load_file(filename)
		list = {}
		begin
			file = File.open(filename)
			file.each_line do |line|
				key = Moshi.mangle(line.chomp!.dup)
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

	def Moshi.mangle(word)
		# lowercase it!
		word.downcase!
		puts word

		word.gsub!(/([a-z])\1+/) { |s| s[0] + '?' }
		puts word

		puts word.gsub!(/[aeiou]/, '*')
		puts word
	end
end