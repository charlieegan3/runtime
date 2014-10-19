Rails.application.routes.draw do

  root 'query#index'

  post 'submit' => 'query#submit'
  get 'about' => 'query#about'

end
