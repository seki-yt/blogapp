Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'articles#index'

  #/articles/:article_id/commentsみたいにarticlesの下にcommentsにurlを作る方法は
  #入れ子構造にしてresourcesを作れば良い
  resources :articles do
    resources :comments, only: [:new, :create]
  end
end
