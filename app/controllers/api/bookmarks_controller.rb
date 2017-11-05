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
      render json: bookmark, status: :created
    else
      render json: bookmark.errors, status: :bad_request
    end
  end

  def update
    if @bookmark.update bookmark_params
      render json: @bookmark
    else
      render json: @bookmark.errors, status: :unprocessable_entity
    end
  end

  private

  def set_bookmark
    begin
      @bookmark = Bookmark.find params[:id]
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :not_found
    end
  end

  def bookmark_params
    params.permit(:title, :url, :shortening)
  end
end
