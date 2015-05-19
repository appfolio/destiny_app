authorization do
  role :opsapp_admin do
    has_permission_on :users, :to => :manage
    has_permission_on :home, :to => :read
  end

  role :guest do
    has_permission_on :users, :to => :manage # devise has to be able to create & update users
    has_permission_on :home, :to => :read
  end
end

privileges do
  # default privilege hierarchies to facilitate RESTful Rails apps
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :create, :includes => :new
  privilege :read, :includes => [:index, :show]
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end
