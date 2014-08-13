require 'spec_helper'

describe Caracal::Core::Models::TableModel do
  subject do 
    described_class.new do
      data            [ ['top left', 'top right'], ['bottom left', 'bottom right'] ]
      align           :right
      border_color    '666666'
      border_line     :double
      border_size     8
      border_spacing  4
      width           8000
    end
  end
  
  #-------------------------------------------------------------
  # Configuration
  #-------------------------------------------------------------

  describe 'configuration tests' do
    
    # constants
    describe 'constants' do
      it { expect(described_class::DEFAULT_TABLE_ALIGN).to          eq :left }
      it { expect(described_class::DEFAULT_TABLE_BORDER_COLOR).to   eq 'auto' }
      it { expect(described_class::DEFAULT_TABLE_BORDER_LINE).to    eq :single }
      it { expect(described_class::DEFAULT_TABLE_BORDER_SIZE).to    eq 0 }
      it { expect(described_class::DEFAULT_TABLE_BORDER_SPACING).to eq 0 }
    end
    
    # accessors
    describe 'accessors' do
      it { expect(subject.table_align).to          eq :right }
      it { expect(subject.table_border_color).to   eq '666666' }
      it { expect(subject.table_border_line).to    eq :double }
      it { expect(subject.table_border_size).to    eq 8 }
      it { expect(subject.table_border_spacing).to eq 4 }
      it { expect(subject.table_width).to          eq 8000 }
    end
    
  end
  
  
  #-------------------------------------------------------------
  # Public Methods
  #-------------------------------------------------------------
  
  describe 'public method tests' do
  
    #=============== GETTERS ==========================
    
    describe '.cells' do
      let(:data) { subject.cells }
      
      it { expect(data[0]).to    be_a(Array) }
      it { expect(data[0][0]).to be_a(String) }   # TODO: Switch when data nodes modeled properly
    end
    
    
    #=============== SETTERS ==========================
    
    # .align
    describe '.align' do
      before { subject.align(:center) }
      
      it { expect(subject.table_align).to eq :center }
    end
    
    # .border_color
    describe '.border_color' do
      before { subject.border_color('999999') }
      
      it { expect(subject.table_border_color).to eq '999999' }
    end
    
    # .border_size
    describe '.border_size' do
      before { subject.border_size(24) }
      
      it { expect(subject.table_border_size).to eq 24 }
    end
    
    # .width
    describe '.width' do
      before { subject.width(7500) }
      
      it { expect(subject.table_width).to eq 7500 }
    end
    
    
    
    
    #=============== VALIDATION ===========================
    
    describe '.valid?' do
      describe 'when data provided' do
        it { expect(subject.valid?).to eq true }
      end
      describe 'when no data provided' do
        before do
          allow(subject).to receive(:cells).and_return([[]])
        end
        
        it { expect(subject.valid?).to eq false }
      end
    end
  
  end
  
  
  #-------------------------------------------------------------
  # Private Methods
  #-------------------------------------------------------------
  
  describe 'private method tests' do
    
    # .option_keys
    describe '.option_keys' do
      let(:actual)     { subject.send(:option_keys).sort }
      let(:expected1)  { [:data, :align, :width] }
      let(:expected2)  { [:border_color, :border_line, :border_size, :border_spacing] }
      let(:expected3)  { [:border_top, :border_bottom, :border_left, :border_right, :border_horizontal, :border_vertical] }
      let(:expected)   { (expected1 + expected2 + expected3).sort }
      
      it { expect(actual).to eq expected }
    end
    
  end
  
end