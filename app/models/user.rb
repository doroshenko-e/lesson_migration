class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :first_name, :last_name, :email, :birthday, :active,
                  :password, :password_confirmation, :images_attributes
  has_many :images, as: :imageable
  accepts_nested_attributes_for :images

  scope :age, where('birthday < ?', 21.year.ago) # under 21 year
  scope :active, where(active: true) # active
  scope :active_above, -> { active.age } # active under 21 year

  validate :age_fifteen?
  validates :email, uniqueness: { case_sensative: false }
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.
                      )+[a-z]{2,})\Z/i, on: :create

  before_save do |user|
    user.active = true if user.first_name.present? && user.last_name.present?
  end

  # selects users with query in first or last name
  def self.search_name(*)
    where('first_name ILIKE ? or last_name ILIKE ?', '%#{query}%', '%#{query}%')
  end

  private

  # Method for age validation
  def age_fifteen?
    if (birthday + 15.year) > Date.today
      errors.add(:birthday, 'You are too young')
    end
  end
end
