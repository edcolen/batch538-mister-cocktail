Rails.application.routes.draw do
  root to: 'cocktails#index'
  patch 'cocktails/:id/reviews/:id/like', to: 'reviews#like', as: :like_review

  resources :cocktails, shallow: true do
    resources :doses, only: %i[create destroy]
    resources :reviews, only: %i[create]
  end
end
