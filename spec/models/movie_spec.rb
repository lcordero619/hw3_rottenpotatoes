require 'spec_helper'

describe Movie do
  fixtures :movies
  it 'should provide results when queried by director' do
    result = Movie.search_by_director('Some Director')
    result.should_not == nil
    result.count.should == 2
    
  end
  it 'should raise error when queried with empty director' do
    lambda {Movie.search_by_director(nil)}.should raise_error(ArgumentError)
    lambda {Movie.search_by_director("")}.should raise_error(ArgumentError)
  end
end

