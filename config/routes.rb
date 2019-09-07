Rails.application.routes.draw do
  devise_for :users

  resources :items, except: [:show, :new, :edit] do
    collection do
      patch :sort
    end
  end

  resources :lists, except: [:edit]

  root to: "lists#index"
end
