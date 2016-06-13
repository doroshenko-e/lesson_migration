# +2) Добавить валидации: email уникальный, регистрация только с 15 лет, проверка формата email
# +/- 3) Создать scope который будет выводить активных пользователей старше 21 года
# 4) Написать self метод search который будет искать пользователей по имени и фамилии
# +5) Добавить callback который перед save будет смотреть если Имя или Фамилия не указаны то active флаг становится в false. Если всё указано, то тогда true

class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :birthday, :active
  has_many :images, as: :imageable

  #scope :age, where("Date.today - 21.year >= ?", :birthday)
  scope :active, where(:active => true)
  #scope :active_above, -> {active, where("Date.today - 21.year >= ?", :birthday)} 
  
  #validate :age_fifteen?
  validates :email, :uniqueness => {:case_sensative => false}
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

  before_save do |user|
  	user.active = true if user.first_name.present? && user.last_name.present?
  	#else
  	#user.active = false
  	#end
  end

  private
  #something wrong
  def age_fifteen?
  	if (Date.today - 15.year) >= birthday
  		errors.add(:birthday, "can't be bellow 15")
  	end
  end

  #join method for first and last names
  def full_name
  	"#{self.first_name} + #{self.last_name}"
  end

  #selects users with query ni first nae or last name
  def self.serch_by_full_name(query)
  	where("full_name ILIKE ?", "%#{query}%")
  end

end
