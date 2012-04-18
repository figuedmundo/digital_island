# == Schema Information
#
# Table name: usuarios
#
#  id              :integer         not null, primary key
#  nombre          :string(255)
#  apellido        :string(255)
#  email           :string(255)
#  telefono        :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean         default(FALSE)
#  tecnico         :boolean         default(FALSE)
#  vendedor        :boolean         default(FALSE)
#  cliente         :boolean         default(TRUE)
#

class Usuario < ActiveRecord::Base
  attr_accessible :apellido, :email, :nombre, :telefono, :password, :password_confirmation
  has_secure_password
  before_save :create_remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_TELEFONO_REGEX = /^([0-9])*$/

  validates :nombre,    presence: true,
                        length: { maximum: 50 }

  validates :apellido,  presence: true,
                        length: { maximum: 50 }

  validates :email,     presence: true,
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false }

  validates :telefono,  presence: true,
                        length: { maximum: 15 },
                        format: { with: VALID_TELEFONO_REGEX }

  validates :password,  presence: true,
                        length: { minimum: 6 }
                        
  validates :password_confirmation,  presence: true


  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

end
