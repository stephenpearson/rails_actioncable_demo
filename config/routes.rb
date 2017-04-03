Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  resources :items do
    resources :people
  end
  resources :people
end
