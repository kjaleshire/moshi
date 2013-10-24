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
	end

	describe '#search' do
		before { trie.store('supermacintatertosh') }

		it "should return the same word as searched for" do
			expect(trie.search('supermacintatertosh')).to eq('supermacintatertosh')
			expect(trie.search('supermacintatertosh')).to_not eq('supercalafragilistic')
		end

		it "should not return a sub-word of any words already stored" do
			expect(trie.search('supercala')).to be_nil
			expect(trie.search('supermac')).to be_nil
			expect(trie.search('super')).to be_nil
		end
	end
end