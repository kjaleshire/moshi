require 'spec_helper'
require 'moshi/engine'
require 'moshi/cli'

describe Moshi::Engine do
	let(:engine) { Moshi::Engine.new(File.expand_path('../testlist', __FILE__)) }

	describe '#suggest' do
		it "should not return words longer than the original" do
			expect(engine.suggest("Phoronic", nil)).to eq('phoronic')
			expect(engine.suggest("Phoronic", nil)).to_not eq('Pharaonic')
		end
	end

	describe '.mangle' do

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
		it "should load a list of words into a new hash" do
			expect(engine.dictionary[engine.mangle('pretty')]).to include('pretty')
			expect(engine.dictionary[engine.mangle('glum')]).to include('glum')
			expect(engine.dictionary[engine.mangle('beanstalk')]).to include('beanstalk')
			expect(engine.dictionary[engine.mangle('lollipop')]).to include('lollipop')
			expect(engine.dictionary[engine.mangle('slammed')]).to include('slammed')
			expect(engine.dictionary[engine.mangle('cacaphony')]).to be_nil
			expect(engine.dictionary[engine.mangle('glasgow')]).to be_nil
			expect(engine.dictionary[engine.mangle('mariachi')]).to be_nil
			expect(engine.dictionary[engine.mangle('quagmire')]).to be_nil
			expect(engine.dictionary[engine.mangle('zimbabwe')]).to be_nil
		end
	end

	describe '#mutate' do
		it "should generate a word that can be mangled to the same as the original" do
			mutant = engine.mutate('supercalafragilistic')
			expect(engine.mangle(mutant)).to eq(engine.mangle('supercalafragilistic'))
			mutant_2 = engine.mutate('expealidocious')
			expect(engine.mangle(mutant_2)).to eq(engine.mangle('expealidocious'))
		end
	end
end