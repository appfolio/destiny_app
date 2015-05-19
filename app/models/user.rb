# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  email                :string(255)      default(""), not null
#  encrypted_password   :string(128)      default(""), not null
#  remember_created_at  :datetime
#  sign_in_count        :integer          default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  authentication_token :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  name                 :string(255)
#  mobile_number        :string(255)
#  user_roles           :string(255)
#

class User < ActiveRecord::Base
  using_access_control

  class ROLE
    OPSAPP_ADMIN = "OpsApp Admin"
  end

  # Include default devise modules. Others available are:
  attr_accessor :remote_login

  devise :database_authenticatable, :rememberable, :trackable, :timeoutable, :timeout_in => 4.hours

  scope :notifiable, -> { where("mobile_number IS NOT NULL") }

  def password_required?
    false
  end

  def after_remote_authentication(remote_user)
    self.name       = "#{remote_user.first_name} #{remote_user.last_name}"
    self.user_roles = remote_user.respond_to?(:user_roles) ? remote_user.user_roles : ''
    Authorization.current_user = self
  end

  def to_json(options = {})
    super(self.class.format_options.merge(options))
  end

  def to_xml(options = {})
    super(self.class.format_options.merge(options))
  end

  def self.format_options
    { :methods => :name, :only => [:email, :id, :mobile_number, :user_roles] }
  end

  def roles
    !user_roles.to_s.empty? ? user_roles.split(',') : []
  end

  def has_role?(r)
    roles.include? r
  end

  def role_symbols
    if has_role? User::ROLE::OPSAPP_ADMIN
      [:opsapp_admin]
    else
      [:guest]
    end
  end
end
