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
      session.first("nav").click_link("Challenges")

      if session.has_button?("Begin")
        session.click_button("Begin")
      else
        session.click_button("Continue")
      end

      session.click_button("Continue")

      session.click_link("Log Out")
    end
  end
end
