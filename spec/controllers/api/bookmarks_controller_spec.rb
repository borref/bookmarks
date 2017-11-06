require 'rails_helper'

RSpec.describe Api::BookmarksController, type: :controller do
  let!(:bookmark) { create(:bookmark) }

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(:bookmarks).not_to be_empty
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show, params: { id: bookmark.id }
      expect(response).to have_http_status(:success)
    end

    it 'returns http not found status code' do
      expect do
        get :show, params: { id: 'not exists' }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'GET #update' do
    it 'returns http success' do
      get :update, params: { id: bookmark.id }
      expect(response).to have_http_status(:success)
    end

    it 'returns http not found status code' do
      expect do
        get :update, params: { id: 'not exists' }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST #create' do
    it 'creates a bookmark' do
      data = {
        title: 'valid',
        url: 'https://github.com/rspec/',
        shortening: 'https://goo.gl/AfoQuV'
      }
      expect do
        post :create, params: data
        expect(response).to have_http_status(:success)
      end
    end

    it 'does not create a bookmark because is invalid data' do
      data = {
        url: '/rspec/',
        shortening: 'https://goo.gl/AfoQuV'
      }
      expect do
        post :create, params: data
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'PUTS #update' do
    it 'updates a bookmark' do
      put :update, params: { id: bookmark.id, title: 'updated bookmark title' }
      expect(response).to have_http_status(:success)
    end

    it 'does not update a bookmark because is invalid data' do
      put :update, params: { id: bookmark.id, url: '/not-valid/' }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a bookmark' do
      expect do
        delete :destroy, params: { id: bookmark.id }
        expect(response).to have_http_status(:success)
      end
    end
  end
end
