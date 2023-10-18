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

  def password_complexity
    if password.present? and not password.match(/\A(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[!@#$%^&*])[ -~]{8,32}\z/)
      errors.add :password, "は半角英数字特殊記号を含め、8〜32文字で設定してください"
    end
  end
end
