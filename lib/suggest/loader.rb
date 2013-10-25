module Suggest
	def Suggest.load_words(filename, trie)
		begin
			file = File.open(filename)
			file.each_line do |line|
				trie.store(line.chomp)
			end
		rescue Exception => e
			puts e
			exit 1
		ensure
			file.close unless file.nil?
		end
	end
end