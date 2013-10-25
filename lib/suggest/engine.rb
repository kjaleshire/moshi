module Suggest
	class Engine
		def initialize trie
			@word_list = trie
		end

		def suggest(word)
			@word_list.search(word)
		end
	end
end