DestinyApp::Application.routes.draw do
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
  get 'references/sqli' => 'references#sqli'
  get 'references/xss' => 'references#xss'
  get 'references/xss_read_letters' => 'references#xss_read_letters'
  post 'references/xss_deliver_letter' => 'references#xss_deliver_letter'

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

  Queries.each do |query|
    post "references/#{query[:input_form][:action_url]}" => "references##{query[:input_form][:action_url]}"
  end

end
