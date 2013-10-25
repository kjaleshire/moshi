require 'moshi/loader'
require 'moshi/trie'

describe 'Moshi.load_words' do
	let(:list) { Moshi::Trie.new }

	it "should load a list of words into a new trie" do
		path = File.expand_path('../testlist', __FILE__)
		Moshi.load_words(path, list)

		expect(list.search('pretty')).to eq('pretty')
		expect(list.search('glum')).to eq('glum')
		expect(list.search('beanstalk')).to eq('beanstalk')
		expect(list.search('lollipop')).to eq('lollipop')
		expect(list.search('slammed')).to eq('slammed')

		expect(list.search('cacaphony')).to be_nil
		expect(list.search('glasgow')).to be_nil
		expect(list.search('mariachi')).to be_nil
		expect(list.search('quagmire')).to be_nil
		expect(list.search('zimbabwe')).to be_nil
	end
end