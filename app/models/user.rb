# +2) Добавить валидации: email уникальный, регистрация только с 15 лет, проверка формата email
# 3) Создать scope который будет выводить активных пользователей старше 21 года
# 4) Написать self метод search который будет искать пользователей по имени и фамилии
# +5) Добавить callback который перед save будет смотреть если Имя или Фамилия не указаны то active флаг становится в false. Если всё указано, то тогда true

class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :birthday, :active
  has_many :images, as: :imageable

  scope :age, where("Date.today - 21.year >= ?", :birthday)
  scope :active, where(:active => true)
  
  validate :age_fifteen?
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
end
