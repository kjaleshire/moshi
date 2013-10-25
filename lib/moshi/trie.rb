module Moshi
	class Trie
		attr_accessor :trie

		def initialize(word='')
			@trie = {}
			store(word)
		end

		def store(store_word)
			if !store_word.empty?
				@trie[store_word.to_sym] = store_word
				#store_helper(store_word, store_word.downcase.split(//), @trie)
			end
		end

		def search(search_word)
			if !search_word.empty?
				@trie[search_word.to_sym]
				#search_helper(search_word, search_word.downcase.split(//), @trie)
			end
		end

		private

			def store_helper(full_word, word, list)
				if !word.empty?
					letter = word.shift
					list[letter] ||= {}
					store_helper(full_word, word, list[letter])
				else
					list[full_word] = full_word
				end
			end

			def search_helper(search_word, word, list)
				if list
					if !word.empty?
						letter = word.shift
						search_helper(search_word, word,list[letter])
					else
						list[search_word]
					end
				end
			end

		#end private
	end
end