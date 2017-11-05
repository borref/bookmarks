# frozen_string_literal: true

class Api::BookmarksController < ApplicationController
  before_action :set_bookmark, only: %i[show update destroy]

  def index
    render json: Bookmark.all
  end

  def show
    render json: @bookmark
  end

  def create
    bookmark = Bookmark.new(bookmark_params)

    if bookmark.save
      sign_in bookmark
      render(json: bookmark, status: :created)
    else
      render(json: bookmark.errors, status: :bad_request)
    end
  end

  def update
    current_user.assign_attributes(user_params)
    if current_user.save
      render(json: current_user)
    else
      render(json: current_user.errors, status: :bad_request)
    end
  end

  private

  def set_bookmark
    @bookmark = Bookmark.find params[:id]
  end

  def bookmark_params
    params.permit(:title, :url, :shortening)
  end
end
