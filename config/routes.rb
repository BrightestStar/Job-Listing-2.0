Rails.application.routes.draw do
  devise_for :users

  resources :jobs do
    resources :resumes
  end

  namespace :admin do
    resources :jobs do
      member do
        post :hide
        post :public
      end
      resources :resumes
    end
  end

  resources :resumes

  root 'jobs#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
