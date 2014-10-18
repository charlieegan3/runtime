Rails.application.routes.draw do

  root 'query#index'

  post 'submit' => 'query#submit'

end
