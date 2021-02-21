Rails.application.routes.draw do
  root to: 'cocktails#index'

  resources :cocktails, shallow: true do
    resources :doses, only: %i[create destroy]
    resources :reviews, only: %i[create]
  end
end
