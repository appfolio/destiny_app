module GateGuard
  def self.read_letter request, tables_prefix
    session = Capybara::Session.new(:poltergeist)
    url = "#{request.protocol}#{request.host}:#{request.port}"+"/"

    #Find the Guard with the same tables prefix
    unless User.where(name: "Guard", tables_prefix: tables_prefix).present?
      User.create({
        email: "guard",
        encrypted_password: User.new({password: "guardafiymecappin"}).encrypted_password,
        name: "Guard",
        tables_prefix: tables_prefix
      })
    end

    Thread.new do
      session.visit url
      session.fill_in(:user_email, with: "guard")
      session.fill_in(:user_password, with: "guardafiymecappin")
      session.click_button("Log in")

      url = "#{request.protocol}#{request.host}:#{request.port}"+"/castle/read_letters"
      session.visit url
      url = "#{request.protocol}#{request.host}:#{request.port}"+"/"
      session.visit url
      session.click_link("Log Out")
    end
  end
end
