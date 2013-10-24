module Suggest
	class Trie
		attr_accessor :trie

		def initialize(word='')
			@trie = {}
			store(word)
		end

		def store(store_word)
			store_helper(store_word, store_word.split(//), @trie)
		end

		def search(search_word)
			subhash = search_hash(search_word.split(//), @trie)
			subhash[:word]
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
					list[:word] = fullword unless fullword.empty?
				end
			end

			def search_hash(search_word, list)
				if list
					if !search_word.empty?
						letter = search_word.shift
						search_helper(search_word, list[letter])
					else
						list
					end
				end
			end

		#end private
	end
end