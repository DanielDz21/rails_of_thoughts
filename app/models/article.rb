class Article < ApplicationRecord
  has_rich_text :content

  validates :title, presence: true

  def read_time
    words_per_minute = 220
    content_length = content.to_plain_text.split.size
    (content_length / words_per_minute).floor
  end
end
