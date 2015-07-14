DestinyApp::Application.routes.draw do
  mount Browserlog::Engine => '/logs'

  devise_for :users

  devise_scope :user do
    authenticated :user do
      root 'home#index', as: :authenticated_root
    end

    unauthenticated :user do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  get 'references/' => 'references#index'

  get 'csrf/' => 'csrf#index'

  get 'cross_site_scripting/' => 'cross_site_scripting#index'
  get 'cross_site_scripting/read_letters' => 'cross_site_scripting#read_letters'
  post 'cross_site_scripting/deliver_letter' => 'cross_site_scripting#deliver_letter'

  get 'sql_injection/' => 'sql_injection#index'
  get 'sql_injection/sqli' => 'sql_injection#sqli'
  Queries.each do |query|
    post "sql_injection/#{query[:input_form][:action_url]}" => "sql_injection##{query[:input_form][:action_url]}"
  end

  get 'mass_assignment/ma' => 'mass_assignment#ma'
  post 'mass_assignment/create_chest' => 'mass_assignment#create_chest'
  MassAssignments.each do |ma|
    name = ma[:name]
    post "mass_assignment/safe_#{name}" => "mass_assignment#safe_#{name}"
    post "mass_assignment/vulnerable_#{name}" => "mass_assignment#vulnerable_#{name}"
  end

  get 'challenges/' => 'challenges#index'
  post 'challenges/setup_challenge_environment' => 'challenges#setup_challenge_environment'
  post 'challenges/restart' => 'challenges#restart'
  get 'challenges/start' => 'challenges#start'
  post 'challenges/start_sql' => 'challenges#start_sql'
  post 'challenges/unlock_chest_with' => 'challenges#unlock_chest_with'

  get 'castle/' => 'castle#gate'
  get 'castle/gate' => 'castle#gate'
  post 'castle/deliver_letter' => 'castle#deliver_letter'
  post 'castle/knock' => 'castle#knock'
  get 'castle/read_letters' => 'castle#read_letters'
  post 'castle/push_gate' => 'castle#push_gate'
  post 'castle/unlock_the_gate' => 'castle#unlock_the_gate'
end
