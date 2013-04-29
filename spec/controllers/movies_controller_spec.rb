require 'spec_helper'

describe MoviesController do
  fixtures :movies
  describe 'Find movies by director' do
    before :each do
      @fake_results = [mock('movie1'), mock('movie2')]
    end
    
    it 'should call the model method that performs Director search' do
      Movie.should_receive(:search_by_director).with('hardware').
        and_return(@fake_results)
      post :director_search, {:id => 999}
    end
    describe 'after valid search' do
      before :each do
        Movie.stub(:search_by_director).and_return(@fake_results)
        post :director_search, {:id => 999}
      end
      it 'should select the Director Search Results template for rendering' do
        response.should render_template('director_search')
      end
      it 'should make the Directory search results available to that template' do
        assigns(:movies).should == @fake_results
      end
    end
  end
end

