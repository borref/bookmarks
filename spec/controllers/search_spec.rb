require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  let!(:bookmark) { create(:bookmark) }

  describe 'GET #index' do
    it 'returns http success' do
      get :index, params: { search: 'forbidden' }
      expect(:bookmarks).not_to be_empty
      expect(response).to have_http_status(:success)
    end
  end
end
