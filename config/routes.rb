Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json }
  post "/graphql", to: "graphql#execute"
  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql'

  resources :search, only: []
  get "/dashboard", to: "search#dashboard"
  get "/categories", to: "search#categories"
  get "/merms", to: "search#merms"

  get "/search", to: "search#search"
  get "/advanced-search", to: "search#advanced"

  get "/search-recent", to: "search#recent"
  get "/search-favorite", to: "search#favorite"
  get "/search-category", to: "search#category"
  get "/search-expired", to: "search#expired"
  get "/search-shared", to: "search#shared"
end
