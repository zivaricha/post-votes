Rails.application.routes.draw do
  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'posts/:id/vote'   => 'posts#vote',   as: 'vote_post'
  root                                      :to => 'posts#index'

end
