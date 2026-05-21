# ■サービス概要
HealScanは、質問に回答することで、その日の心身状態に合ったセルフケア方法を提案する診断Webアプリです。
心・身体・脳疲労の3軸から状態を可視化し、ユーザー同士でセルフケア方法を共有できます。

# ■サービスURL
https://www.healscan.jp

# ■ER図
[![Image from Gyazo](https://i.gyazo.com/c0b9e11fe43ef2a2a9ccc2419eabf67e.png)](https://gyazo.com/c0b9e11fe43ef2a2a9ccc2419eabf67e)

# ■使用技術
### バックエンド
- Ruby 3.1.4
- Ruby on Rails 7.2.2.1

### フロントエンド
- HTML
- CSS
- Bootstrap 5
- JavaScript
- Hotwire
  - Turbo
  - Stimulus

### データベース
- MySQL 5.7

### インフラ・開発環境
- Docker
- Docker Compose
- Heroku

### 画像管理
- CarrierWave
- Cloudinary

### 認証
- Sorcery
- Googleログイン（OIDC認証）

### SNS共有で使っている技術
- meta-tags
- 動的OGP
- X(Twitter)共有機能

### メール
- Action Mailer
- Gmail SMTP

### テスト・品質管理
- RSpec
- RuboCop
- Brakeman
- GitHub Actions

# ■インフラ構成図
[![Image from Gyazo](https://i.gyazo.com/1bf8670acf527e47072288e96255c86b.png)](https://gyazo.com/1bf8670acf527e47072288e96255c86b)

# ■実装機能
### 認証機能
- Sorceryを利用した会員登録・ログイン機能
  - メールを介したパスワードリセット機能
  - ログイン状態保持機能
- Google会員登録・ログイン機能
  - Googleアカウント情報を利用したユーザー登録
  - Googleプロフィール画像の取得
  - CSRF対策
- プロフィール編集機能

### 診断機能
- 9問の回答から心・身体・脳疲労を数値化
- 未ログイン状態でも利用可能
- 診断結果のX共有機能（旧Twitter）
- 動的OGP

### 掲示板機能
- 投稿CRUD
- 画像投稿機能
- いいね機能（非同期通信）
- ブックマーク機能（非同期通信）
- コメント投稿機能（非同期通信）
- 検索機能
  - タイトル・本文検索（オートコンプリート）
  - 日付検索

### UI/UX
- レスポンシブ対応
- フラッシュメッセージ
- エラーメッセージ
- ページネーション

### 管理者権限
- ユーザー管理機能
- 投稿管理機能

### テスト・品質管理
- RSpecによるテスト
- RuboCopによるコード解析
- Brakemanによるセキュリティチェック
- GitHub ActionsによるCI

# ■技術工夫
1. 非同期通信機能
- いいね・ブックマーク機能ではTurbo Streamを利用し、ページ全体を更新せず部分更新を実装しユーザビリティを向上。

2. オートコンプリート機能
- 検索フォームにオートコンプリート機能を実装し、入力候補を非同期で取得することでユーザビリティを向上。
- 非同期で候補取得を行っている。

3. 未ログイン診断対応
- 診断機能はログイン不要で利用可能にし、サービス体験までのハードルを下げた。

4. Googleログイン
- Google Identity Servicesを利用しOIDC認証を実装。
- CSRF対策としてg_csrf_token検証を行っている。

5. 管理者 / 一般ユーザーの権限分離
- 一般権限・管理者権限と2つの権限を実装し、セキュリティを向上。

# ■今後の改善予定
- 診断結果の数値の可視化（レーダーチャート表示）
