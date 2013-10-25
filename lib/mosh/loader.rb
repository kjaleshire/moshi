module Mosh
	def Mosh.load_words(filename, dictionary)
		begin
			file = File.open(filename)
			file.each_line do |line|
				dictionary.store(line.chomp)
			end
		rescue Exception => e
			puts e
			exit 1
		ensure
			file.close unless file.nil?
		end
	end
end