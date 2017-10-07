Rails.application.routes.draw do
  devise_for :users

  root 'welcome#index'

  namespace :api do
    namespace :v1 do
      resource :auth_tokens, only: :create

      scope module: 'author' do
        resources :posts, only: [:index, :show, :create], param: :post_id
        resource  :comments, only: [:create, :destroy]
      end
    end
  end
end
