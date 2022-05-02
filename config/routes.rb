Rails.application.routes.draw do
  resources :contact_lists do
    collection do
      get :search
    end
  end

  root to: 'contact_lists#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
