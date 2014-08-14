class Product < ActiveRecord::Base
  validates :title, :description, :image_url, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true
  validates_length_of :title, minimum: 10, too_short: 'title too short'
  validates :image_url, format: {
    with: %r{\.(gif|jpg|png)$}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
  validates :image_url, uniqueness: true
  validates :price, numericality: {less_than_or_equal_to: 1000}
  
  default_scope order: :title
  
  has_many :line_items
  has_many :orders, through: :line_items
  
  before_destroy :ensure_not_referenced_by_any_line_item
  
  def ensure_not_referenced_by_any_line_item
    if line_items.count.zero?
      return true
    else
      errors.add(:base, 'Line items present')
    end
  end
end
