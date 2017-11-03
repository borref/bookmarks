# frozen_string_literal: true

class Site < ApplicationRecord
  # Validations
  validates :url, presence: true, uniqueness: true

  def bookmarks
    Bookmark.where(site_id: self.id)
  end
end
