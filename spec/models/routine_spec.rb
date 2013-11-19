require 'spec_helper'

describe Routine do 
  it 'should have a valid factory' do
    FactoryGirl.create(:routine).should be_valid
  end
end