require 'spec_helper'

describe RedisTripsController do

  let(:search_term) { create(:search_term) }

  describe 'redis_trips#index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end

    it '@teams should contain all search_terms' do
      search_term
      get :index
      expect(assigns(:teams)).to eq([search_term])
    end
  end  
end