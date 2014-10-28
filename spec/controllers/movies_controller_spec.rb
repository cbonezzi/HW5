require 'spec_helper'
 
describe MoviesController do
  describe 'searching TMDb' do
    before :each do
      @fake_results = [mock('movie1'), mock('movie2')]
    end
    it 'should call the model method that performs TMDb search' do
      expect(Tmdb::Movie).to receive(:find).with('Aladdin')
      post :search_tmdb, {:search_terms => 'Aladdin'}
    end
    describe 'after valid search' do
      before :each do
	allow(:find_in_tmdb).and_return(@fake_results)
	post :search_tmdb, { :search_terms => 'Aladdin' }
      end
      it 'should select the Search Results template for rendering' do
	response.should render_template('search_tmdb')
      end
      it 'should make the TMDb search results available to that template' do
	assigns(:movies).should == @fake_results
      end
    end
  end
end
