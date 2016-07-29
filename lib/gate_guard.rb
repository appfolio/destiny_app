module GateGuard
  def self.read_letter request, tables_prefix
    session = Capybara::Session.new(:poltergeist)
    password = Rails.env.production? ? ENV["GUARD_PASS"] : "guardafiymecappin"
    url = "#{request.protocol}#{request.host}:#{request.port}"+"/"

    #Find the Guard with the same tables prefix
    unless User.where(name: "Guard", tables_prefix: tables_prefix).present?
      guard = User.new({
        email:"guard@guard.com",
        password: password,
        name: "Guard",
        tables_prefix: tables_prefix,
        confirmed_at: "2015-05-03 00:00:00"
      })
      guard.save!
    end

    Thread.new do
      session.visit url
      session.fill_in(:user_email, with: "guard@guard.com")
      session.fill_in(:user_password, with: password)
      session.click_button("Log in")

      url = "#{request.protocol}#{request.host}:#{request.port}"+"/castle/read_letters"
      session.visit url
      url = "#{request.protocol}#{request.host}:#{request.port}"+"/"
      session.visit url
      session.click_link("Log Out")
    end
  end
end
