Rails.application.routes.draw do
  root "static_pages#top"
  resources :users,    only: %i[new create]
  resources :boards, only: %i[index new create show edit destroy update] do
    resources :comments, only: %i[create edit destroy], shallow: true
    resource :like, only: %i[create destroy]
    collection do
      get :bookmarks
      get :autocomplete
    end
  end

  resources :bookmarks, only: %i[create destroy]
  resources :diagnoses, only: %i[new create show]
  resource :profile, only: %i[show edit update]
  resources :password_resets, only: %i[new create edit update]
  get    "login",  to: "user_sessions#new"
  post   "login",  to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy", as: :logout

  # 管理者権限用
  namespace :admin do
    root to: "dashboards#show"
    resources :boards
    resources :users
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

end
