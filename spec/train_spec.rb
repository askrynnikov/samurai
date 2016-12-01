require_relative 'spec_helper'

describe Train do
  it 'raises an error if the number does not match the specified format' do
    expect { Train.new('201256', nil) }.to raise_error(TypeError)
  end
  it 'does not raises an error' do
    expect { Train.new('201-56', nil) }.not_to raise_error
  end
end
