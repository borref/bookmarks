# frozen_string_literal: true

class Bookmark < ApplicationRecord
  # Validations
  validates :url, :title, presence: true, uniqueness: true
  validate :validate_url

  # Callbacks
  before_save :set_site

  def site
    Site.find(site_id)
  end

  def self.search(title = nil)
    query = 'title LIKE ?'
    Bookmark.where(query, "%#{title}%")
  end

  private

  def validate_url
    errors.add(:url, 'Invalid URL') unless uri_is_valid?(url)
  end

  def set_site
    url_host = URI.parse(url).host
    site = Site.find_or_create_by(url: url_host)
    self.site_id = site.id
  end

  def uri_is_valid?(url)
    uri = URI.parse(url)
    return false if uri.host.nil?
    true
  rescue URI::InvalidURIError
    false
  end
end
