require 'spec_helper'
require 'moshi/engine'
require 'moshi/cli'

describe Moshi::Engine do

	before do
		@engine = Moshi::Engine.new(File.expand_path('../fixtures/testlist', __FILE__))
	end

	it { @engine.should respond_to(:suggest)}
	it { @engine.should respond_to(:generate)}
	it { @engine.should respond_to(:dictionary)}

	it { Moshi::Engine.should respond_to(:mangle)}
	it { Moshi::Engine.should respond_to(:mutate)}

	describe '#suggest' do
		subject { @engine.suggest('Phoronic') }

		context "should not return words longer than the original" do
			it { should_not eq('Pharaonic') }
		end

		context "should return the closest matching word" do
			it { should eq('phoronic') }
		end
	end

	describe '.mangle' do
		subject { Moshi::Engine.mangle(word) }

		context "should return the properly mangled word" do
			context do
				let(:word) { 'crossbow' }
				it { should eq('cr*sb*w') }
			end

			context do
				let(:word) { 'shishkebab' }
				it { should eq('sh*shk*b*b') }
			end

			context do
				let(:word) { 'zeebrrinny' }
				it { should eq('z*br*ny') }
			end

		end

		describe "comparing mangled words from the spec" do
			subject { Moshi::Engine.mangle(word) }

			context "should reduce to the same key" do
				context do
					let(:word) { 'CUNsperrICY' }
					it { should eq(Moshi::Engine.mangle('conspiracy')) }
				end
				context do
					let(:word) { 'inSIDE' }
					it { should eq(Moshi::Engine.mangle('inside')) }
				end
				context do
					let(:word) { 'jjoobbb' }
					it { should eq(Moshi::Engine.mangle('job')) }
				end
				context do
					let(:word) { 'weke' }
					it { should eq(Moshi::Engine.mangle('wake')) }
				end

			end
		end

	end

	describe '#generate' do
		let(:wordlist) { @engine.generate(10) }
		subject { wordlist }

		its(:length) { should eq(10) }

	end

	describe '.mutate' do

		let(:klass) { @engine.class }
		subject { klass.mangle(klass.mutate(word)) }

		context "should generate a word that can be mangled to the same as the original" do
			context do
				let(:word) { 'supercalafragilistic' }
				it { should eq(klass.mangle(klass.mutate('supercalafragilistic'))) }
				it { should_not eq(klass.mangle(klass.mutate('expealidocious'))) }
			end

			context do
				let(:word) { 'expealidocious' }
				it { should eq(klass.mangle(klass.mutate('expealidocious'))) }
				it { should_not eq(klass.mangle(klass.mutate('supercalafragilistic'))) }
			end

		end
	end

	describe '#load_file' do
		context "should have loaded a list of words into a new hash" do
			subject { @engine.dictionary[Moshi::Engine.mangle(word)] }

			context { let(:word) { 'pretty' }; it { should include('pretty') } }
			context { let(:word) { 'glum' }; it { should include('glum') } }
			context { let(:word) { 'beanstalk' }; it { should include('beanstalk') } }
			context { let(:word) { 'lollipop' }; it { should include('lollipop') } }
			context { let(:word) { 'slammed' }; it { should include('slammed') } }
			context { let(:word) { 'cacaphony' }; it { should be_nil } }
			context { let(:word) { 'glasgow' }; it { should be_nil } }
			context { let(:word) { 'mariachi' }; it { should be_nil } }
			context { let(:word) { 'quagmire' }; it { should be_nil } }
			context { let(:word) { 'zimbabwe' }; it { should be_nil } }

		end
	end
end
