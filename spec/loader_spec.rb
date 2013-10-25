require 'moshi/loader'
require 'moshi/trie'

describe 'Moshi.load_words' do

	it "should load a list of words into a new trie" do
		path = File.expand_path('../testlist', __FILE__)
		list = Moshi.load_file(path)

		expect(list['pretty']).to eq('pretty')
		expect(list['glum']).to eq('glum')
		expect(list['beanstalk']).to eq('beanstalk')
		expect(list['lollipop']).to eq('lollipop')
		expect(list['slammed']).to eq('slammed')
		expect(list['cacaphony']).to be_nil
		expect(list['glasgow']).to be_nil
		expect(list['mariachi']).to be_nil
		expect(list['quagmire']).to be_nil
		expect(list['zimbabwe']).to be_nil
	end
end