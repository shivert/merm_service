Query = GraphQL::ObjectType.define do
  name 'Query'

  field :merms, Queries::Merms
  field :dashboardMerms, Queries::DashboardMerms
  field :merm, Queries::GetMerm
  field :mermByUrl, Queries::MermByUrl
  field :dashboardCategories, Queries::DashboardCategories
  field :categories, Queries::Categories
  field :users, Queries::Users
  field :usersAll, Queries::UsersAll
  field :tags, Queries::Tags
  field :sharedMerms, Queries::SharedMerms
end
