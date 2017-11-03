require 'rails_helper'

RSpec.describe BookmarksController, type: :controller do
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
      end.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end

  describe 'GET #edit' do
    it 'returns http success' do
      get :edit, params: { id: bookmark.id }
      expect(response).to have_http_status(:success)
    end

    it 'returns http not found status code' do
      expect do
        get :edit, params: { id: 'not exists' }
      end.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end

  describe 'POST #create' do
    it 'redirects to index bookmarks' do
      data = {
        title: 'valid',
        url: 'https://github.com/rspec/',
        shortening: 'https://goo.gl/AfoQuV'
      }
      post :create, params: { bookmark: data }
      expect(response).to redirect_to(bookmarks_path)
    end

    it 'creates a bookmark' do
      data = {
        title: 'valid',
        url: 'https://github.com/rspec/',
        shortening: 'https://goo.gl/AfoQuV'
      }
      expect do
        post :create, params: { bookmark: data }
      end.to change { Bookmark.count }.by(1)
    end

    it 'does not create a bookmark because is invalid data' do
      data = {
        url: '/rspec/',
        shortening: 'https://goo.gl/AfoQuV'
      }
      expect do
        post :create, params: { bookmark: data }
      end.to_not(change { Bookmark.count })
    end
  end

  describe 'PUTS #update' do
    it 'redirects to index bookmarks' do
      put :update, params: { id: bookmark.id, bookmark: { title: 'changed' } }
      expect(response).to redirect_to(bookmarks_path)
    end

    it 'updated a bookmark' do
      expected = 'changed'
      put :update, params: { id: bookmark.id, bookmark: { title: expected } }
      expect(bookmark.reload.title).to eq(expected)
    end

    it 'does not updates a bookmark because is invalid data' do
      put :update, params: { id: bookmark.id, bookmark: { url: '' } }
      expect(bookmark.reload.url).to_not eq('')
    end
  end

  describe 'DELETE #destroy' do
    it 'redirects to index bookmarks' do
      delete :destroy, params: { id: bookmark.id }
      expect(response).to redirect_to(bookmarks_path)
    end

    it 'deletes a bookmark' do
      expect do
        delete :destroy, params: { id: bookmark.id }
      end.to change { Bookmark.count }.by(-1)
    end
  end
end
