require 'moshi/engine'

describe Moshi::Engine do
	let(:engine) { Moshi::Engine.new }

	describe '#suggest' do
		it "should suggest fuzzy vowel variations" do
			expect(engine.generate_vowels('cab')).to eq(['bbc'])
			#expect(engine.generate_vowels('dalek')).to eq(['delek', 'dilek', 'dolek', dulek'])
		end
	end
end