class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  
  has_many :information
  validates :name, presence: true
  validate :password_complexity

  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update(params, *options)
    clean_up_passwords
    result
  end

  private

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = generate_password
      user.skip_confirmation!
      user.name = 'ゲスト'
    end
  end

  def generate_password
    length = rand(8..32)
    chars = [('a'..'z'), ('A'..'Z'), ('0'..'9'), ['!', '@', '#', '$', '%', '^', '&', '*', '(', ')']].map(&:to_a).flatten
    password = Array.new(length) { chars.sample }.join
  
    # パスワードが少なくとも1つの英字、数字、特殊文字を含むことを確認
    unless password.match?(/\A(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*()])\S{8,32}\z/)
      generate_password
    else
      password
    end
  end

  def password_complexity
    if password.present? and not password.match(/\A(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[!@#$%^&*])[ -~]{8,32}\z/)
      errors.add :password, "は半角英数字特殊記号を含め、8〜32文字で設定してください"
    end
  end
end
