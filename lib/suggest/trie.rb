module Suggest
	class Trie
		attr_accessor :trie

		def initialize(word='')
			@trie = {}
			store(word)
		end

		def store(store_word)
			if !store_word.empty?
				store_helper(store_word, store_word.split(//), @trie)
			end
		end

		def search(search_word)
			if !search_word.empty?
				subhash = search_hash(search_word.split(//), @trie)
				subhash[:word] if subhash
			end
		end

		def subwords(search_word)
			subhash = search_hash(search_word.split(//), @trie)
		end

		private

			def store_helper(fullword, word, list)
				if !word.empty?
					letter = word.shift
					list[letter] ||= {}
					store_helper(fullword, word, list[letter])
				else
					list[:word] = fullword
				end
			end

			def search_hash(search_word, list)
				if list
					if !search_word.empty?
						letter = search_word.shift
						search_hash(search_word, list[letter])
					else
						list
					end
				end
			end

		#end private
	end
end