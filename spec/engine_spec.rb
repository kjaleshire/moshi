require 'spec_helper'
require 'moshi/engine'

describe Moshi::Engine do

  let(:engine) { Moshi::Engine.new(File.expand_path('../fixtures/testlist', __FILE__)) }
  let(:klass) { engine.class }

  it { engine.should respond_to(:suggest)}
  it { engine.should respond_to(:generate)}
  it { engine.should respond_to(:dictionary)}

  it { klass.should respond_to(:mangle)}
  it { klass.should respond_to(:mutate)}

  describe '#suggest' do

    subject { engine.suggest(word) }

    context "should not return words longer than the original" do
      let(:word) { "Phoronic" }
      it { should_not eq('Pharaonic') }
      it { should eq('phoronic') }
    end

    context do
      let(:word) { 'CUNsperrICY' }
      it { should eq('conspiracy') }
    end
    context do
      let(:word) { 'inSIDE' }
      it { should eq('inside') }
    end
    context do
      let(:word) { 'jjoobbb' }
      it { should eq('job') }
    end
    context do
      let(:word) { 'weke' }
      it { should eq('wake') }
    end
  end

  describe '#generate' do
    context "creating an array of mutants" do
      let(:word_list) { engine.generate(10) }

      it { word_list.length.should eq(10) }

      it "should generate a word array" do
        word_list.each { |word| word.should match /\w+/ }
      end
    end

    context "creating a mutant array with the original word" do
      let(:word_list) { engine.generate(8, print_original: true) }
      let(:dict_array) { engine.dictionary.values.flatten }

      it { word_list.length.should eq(16) }

      it "should contain the original word before the mutation" do
        word_list.each.with_index do |word, index|
          word.should match /\w+/
          dict_array.should include(word) if index.even?
        end
      end
    end
  end

  describe '.mangle' do

    subject { klass.mangle(word) }

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

    context "comparing mangled words from the spec should reduce to the same key" do
      context do
        let(:word) { 'CUNsperrICY' }
        it { should eq(klass.mangle('conspiracy')) }
      end
      context do
        let(:word) { 'inSIDE' }
        it { should eq(klass.mangle('inside')) }
      end
      context do
        let(:word) { 'jjoobbb' }
        it { should eq(klass.mangle('job')) }
      end
      context do
        let(:word) { 'weke' }
        it { should eq(klass.mangle('wake')) }
      end
    end

  end

  describe '.mutate' do

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

      subject { engine.dictionary[klass.mangle(word)] }

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
