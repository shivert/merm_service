Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json }
  post "/graphql", to: "graphql#execute"
  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql'

  resources :search, only: [:index]
end
