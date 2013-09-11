require 'spec_helper'

describe EventsController do
  let (:event) { create(:event) }

  describe 'events#index' do 
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end

    it '@events should contain all events' do
      get :index
      expect(assigns(:events)).to eq([event])
    end
  end
end