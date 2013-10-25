require 'moshi/engine'
require 'moshi/cli'

describe Moshi::Engine do
	let(:engine) { Moshi::Engine.new(Moshi::CLI::DEFAULT_DICT) }

	describe '#suggest' do

	end

	describe '.mangle' do
		describe "mangling the empty word" do
			it "should return nil" do
				expect(engine.mangle('')).to be_nil
			end
		end

		describe "mangling a word" do
			it "should return the mangled word" do
				expect(engine.mangle('crossbow')).to eq('cr*sb*w')
				expect(engine.mangle('shishkabob')).to eq('sh*shk*b*b')
				expect(engine.mangle('zeebrrinny')).to eq('z*br*ny')
			end
		end

		describe "comparing mangled words from the spec" do
			it "should reduce to the same key" do
				expect(engine.mangle('CUNsperrICY')).to eq(engine.mangle('conspiracy'))
				expect(engine.mangle('inSIDE')).to eq(engine.mangle('inside'))
				expect(engine.mangle('jjoobbb')).to eq(engine.mangle('job'))
				expect(engine.mangle('weke')).to eq(engine.mangle('wake'))
			end
		end
	end

	describe '#load_file' do
		it "should load a list of words into a new trie" do
			path = File.expand_path('../testlist', __FILE__)
			list = engine.load_file(path)

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
end