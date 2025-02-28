Rails.application.routes.draw do
  # ルートパス（アプリのトップページ）
  # アクセスすると `StaticPagesController` の `top` アクションが実行される
  root "static_pages#top"

  # `users` リソースのルーティング
  # `only: %i[new create]` を指定して、`new`（登録フォーム表示）と `create`（登録処理）だけを有効にする
  resources :users, only: %i[new create]

  resources :boards, only: %i[index new create show edit destroy update]

  # ログインページの表示
  # `GET /login` にアクセスすると、`UserSessionsController` の `new` アクションが実行される
  # → ログインフォームを表示
  get 'login', to: 'user_sessions#new'

    # ログイン処理
  # `POST /login` にログイン情報（メールアドレス・パスワード）を送信すると
  # `UserSessionsController` の `create` アクションが実行される
  # → 認証成功ならログイン状態になり、リダイレクトなどの処理が行われる
  post 'login', to: 'user_sessions#create'

  # ログアウト処理
  # `DELETE /logout` にアクセスすると、`UserSessionsController` の `destroy` アクションが実行される
  # → セッションを削除してログアウト処理を行い、トップページへリダイレクト
  delete 'logout', to: 'user_sessions#destroy', as: :logout
end
