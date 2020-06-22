Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_scope :user do
    root to: 'users/sessions#new'
  end

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  resources :campaigns, only: %i[index show] do
    member do
      put :change_status
    end
  end

  resources :invoices, only: %i[index create show update] do
    collection do
      get :search_campaigns
    end

    member do
      put :change_status
      put :remove_campaign
    end
  end

  resources :line_items, only: :index
  resources :line_items, only: %i[show edit update] do
    member do
      put :change_status
    end
  end

  resources :versions, only: %i[index show]
end
