class Restaurant < ActiveRecord::Base
  attr_accessible( :name, :phone, :address,
    :url, :menu_url, :inspection_url, :review_url,
    :delivers, :delivery_fee, :tip_percent, :discount_percent,
    :note)
  scope :alphabetically, order("restaurants.name ASC")
  has_many :meals
  has_many :orders, :through => :meals

  #
  # Plugins
  #

  ajaxful_rateable :stars => 5

  #
  # Methods
  #
  def titleize
    name
  end

  def delivers?
    delivers.present?
  end

  def last_ordered_on
    meal = meals.recent_before_today.first or return
    meal.ordered_on
  end

  def days_since_last_ordered
    last_ordered_on && (Date.today - last_ordered_on).to_i
  end
end

# == Schema Information
#
# Table name: restaurants
#
#  id               :integer         not null, primary key
#  name             :string(255)
#  phone            :string(255)
#  url              :string(255)
#  menu_url         :string(255)
#  address          :text
#  note             :text
#  delivers         :boolean
#  delivery_fee     :float
#  tip_percent      :integer
#  discount_percent :integer
#  inspection_url   :string(255)
#  review_url       :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

