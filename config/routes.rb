Rails.application.routes.draw do
  root "static_pages#top"
  resources :users,    only: %i[new create]
  resources :boards, only: %i[index new create show edit destroy update] do
    resources :comments, only: %i[create edit destroy], shallow: true
  end
  # 診断機能
  resources :diagnoses, only: %i[new create show]

  get    "login",  to: "user_sessions#new"
  post   "login",  to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy", as: :logout
end
