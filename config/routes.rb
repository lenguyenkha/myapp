Rails.application.routes.draw do
  root "static_pages#home"
  get "/login", to: "sessions#new"
  get "/signup", to: "users#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/search", to: "filters#show"
  resources :orders, only: %i(index destroy create) do
    resources :order_details, only: :index
  end
  resources :users, except: %i(index destroy)
  resources :products, only: :show
  resources :ratings, only: %i(show create update)
  resources :comments, only: %i(create destroy)
  resources :account_activations, only: :edit
  resources :password_resets, except: %i(index show destroy)
  resources :suggests, only: %i(new create)
  resource :cart, except: %i(index new edit)
  resource :languages, only: :show
  %w(404 422 500).each do |code|
    match code, to: "errors#show", code: code, via: %i(get post put patch delete)
  end
  namespace :admin do
    root "static_pages#index"
    resources :categories, except: :show
    resources :users, only: %i(index destroy)
    resources :products, except: :show do
      collection do
        get :import, to: "import_products#new"
        post :import, to: "import_products#create"
      end
    end
    resources :orders, only: %i(index update) do
      resources :order_details, only: :index
    end
    resources :suggests, only: %i(index destroy update)
    get "statistics", to:"statistics#index"
  end
end
