module Moshi
	def Moshi.load_file(filename)
		list = {}
		begin
			file = File.open(filename)
			file.each_line do |line|
				list[line.chomp] = line.chomp
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