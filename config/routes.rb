Rails.application.routes.draw do
  devise_for :users

  root 'welcome#index'

  namespace :api do
    namespace :v1 do
      resource :auth_tokens, only: :create
    end
  end
end
