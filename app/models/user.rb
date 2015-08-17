#+------------------------+--------------+------+-----+---------+----------------+
#| Field                  | Type         | Null | Key | Default | Extra          |
#+------------------------+--------------+------+-----+---------+----------------+
#| id                     | int(11)      | NO   | PRI | NULL    | auto_increment |
#| email                  | varchar(255) | NO   | UNI |         |                |
#| encrypted_password     | varchar(128) | NO   |     |         |                |
#| remember_created_at    | datetime     | YES  |     | NULL    |                |
#| sign_in_count          | int(11)      | YES  |     | 0       |                |
#| current_sign_in_at     | datetime     | YES  |     | NULL    |                |
#| last_sign_in_at        | datetime     | YES  |     | NULL    |                |
#| current_sign_in_ip     | varchar(255) | YES  |     | NULL    |                |
#| last_sign_in_ip        | varchar(255) | YES  |     | NULL    |                |
#| name                   | varchar(255) | YES  |     | NULL    |                |
#| mobile_number          | varchar(255) | YES  |     | NULL    |                |
#| created_at             | datetime     | YES  |     | NULL    |                |
#| updated_at             | datetime     | YES  |     | NULL    |                |
#| tables_prefix          | varchar(255) | YES  |     | NULL    |                |
#| reset_password_token   | varchar(255) | YES  | UNI | NULL    |                |
#| reset_password_sent_at | datetime     | YES  |     | NULL    |                |
#| confirmation_token     | varchar(255) | YES  | UNI | NULL    |                |
#| confirmed_at           | datetime     | YES  |     | NULL    |                |
#| confirmation_sent_at   | datetime     | YES  |     | NULL    |                |
#+------------------------+--------------+------+-----+---------+----------------+

class User < ActiveRecord::Base
  devise :database_authenticatable, :omniauthable, :registerable, :recoverable,
    :trackable, :validatable, :confirmable, :timeoutable, :timeout_in => 4.hours

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
    if user
      return user
    else
      registered_user = User.where(:email => access_token.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(name: data["name"],
                           provider:access_token.provider,
                           email: data["email"],
                           uid: access_token.uid ,
                           password: Devise.friendly_token[0,20],
                           confirmed_at: "1994-05-03 00:00:00"
                          )
      end
    end
  end
end
