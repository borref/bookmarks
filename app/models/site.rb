# frozen_string_literal: true

class Site < ApplicationRecord
  # Validations
  validates :url, presence: true, uniqueness: true

  # Relationships
  has_many :bookmarks
end
