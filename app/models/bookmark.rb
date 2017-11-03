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

  private

  def set_site
    url_host = URI.parse(self.url).host
    site = Site.find_or_create_by(url: url_host)
    self.site_id = site.id
  end

  def validate_url
    uri = URI.parse(self.url)
    errors.add(:url, 'invalid host') if uri.host.blank?
  rescue URI::InvalidURIError
    errors.add(:url, 'invalid url')
  end
end
