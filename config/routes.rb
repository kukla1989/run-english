Rails.application.routes.draw do
  root 'articles#index'
  get 'sentence/:id', to: 'articles#sentence'
  get 'run_english', to: "articles#run_english"
  resources :articles
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
