require 'suggest/trie'

describe Suggest::Trie do
	let(:trie)	{ Suggest::Trie.new('supercalafragilistic') }

	describe '#initialize' do
		it "should create a new Trie with a new word stored" do
			expect(trie.search('supercalafragilistic')).to eq('supercalafragilistic')
		end
	end

	describe '#store' do
		it "should store a new word and return it" do
			expect(trie.store('supermacintatertosh')).to eq('supermacintatertosh')
		end

		it "should not store an empty word" do
			expect(trie.store('')).to be_nil
		end
	end

	describe '#search' do
		before { trie.store('supermacintatertosh') }

		it "should return the same word as searched for" do
			expect(trie.search('supermacintatertosh')).to eq('supermacintatertosh')
			expect(trie.search('supermacintatertosh')).to_not eq('supercalafragilistic')
		end

		it "should not return a sub-word of any words already stored" do
			# common to either
			expect(trie.search('supercala')).to be_nil
			expect(trie.search('supermac')).to be_nil

			# common to both
			expect(trie.search('super')).to be_nil
		end

		it "should not return a word that contains another stored word" do
			expect(trie.search('supercalafragilisticexpealidocious')).to_not eq('supercalafragilistic')
		end

		it "should not retrieve an empty word" do
			expect(trie.search('')).to be_nil
		end
	end
end