class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_rich_text :content

  validates :title, presence: true

  def should_generate_new_friendly_id?
    title_changed?
  end

  def read_time
    words_per_minute = 180
    content_length = content.to_plain_text.split.size
    (content_length / words_per_minute.to_f).ceil
  end
end
