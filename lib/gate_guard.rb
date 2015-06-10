module GateGuard
  def self.sign_in request
    session = Capybara::Session.new(:poltergeist)
    url = "#{request.protocol}localhost:#{request.port}"+"/"

    unless User.where(name: "guard guard").present?
      User.create({
        email: "guard",
        encrypted_password: User.new({password: "guardafiymecappin"}).encrypted_password,
        name: "guard guard"
      })
    end

    Thread.new do
      session.visit url
      session.fill_in(:user_email, with: "guard")
      session.fill_in(:user_password, with: "guardafiymecappin")
      session.click_button("Log in")
      session.click_link("Log Out")
    end
  end
end
