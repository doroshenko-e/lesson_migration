# +2) Добавить валидации: email уникальный, регистрация только с 15 лет, проверка формата email
# +3) Создать scope который будет выводить активных пользователей старше 21 года
# +4) Написать self метод search который будет искать пользователей по имени и фамилии
# +5) Добавить callback который перед save будет смотреть если Имя или Фамилия не указаны то active флаг становится в false. Если всё указано, то тогда true

class User < ActiveRecord::Base
	has_secure_password
  attr_accessible :first_name, :last_name, :email, :birthday, :active, :password, :password_confirmation
  has_many :images, as: :imageable

  scope :age, where("birthday < ?", 21.year.ago) #under 21 year
  scope :active, where(:active => true) #active
  scope :active_above, -> { active.age } #active under 21 year
  
  validate :age_fifteen?, :massage => "can't be bellow 15"
  validates :email, :uniqueness => {:case_sensative => false}
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

  before_save do |user|
  	user.active = true if user.first_name.present? && user.last_name.present?
  end


  private

  #Method for age validation
  def age_fifteen?
  	if (self.birthday + 15.year) < Date.today

  	end
  end

  #selects users with query in first or last name 
  def self.search_name(query)
  	where("first_name ILIKE ? or last_name ILIKE ?",  "%#{query}%", "%#{query}%")
  end

end
