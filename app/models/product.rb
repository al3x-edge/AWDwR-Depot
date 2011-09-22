class Product < ActiveRecord::Base
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates_presence_of :title, :description, :image_url
  validates_uniqueness_of :title
  validates :image_url, allow_blank: true, format: { with: %r{\.(gif|jpg|png)$}i, message: 'must be a URL for GIF, JPG or PNG image.' }
  validates_length_of :title, :minimum => 10
  
  has_many :line_items
  
  before_destroy :ensure_not_referenced_by_any_line_item
  
  private
    #ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        errors.add(:base, 'Line Items Are Present')
        return false
      end
    end
end