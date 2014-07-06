class Product < ActiveRecord::Base
  validates :title, :description, :image_url, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true
  validates_length_of :title, minimum: 10, too_short: 'title too short'
  validates :image_url, format: {
    with: %r{\.(gif|jpg|png)$}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
  
  default_scope order: :title
end
