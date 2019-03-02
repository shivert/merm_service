Query = GraphQL::ObjectType.define do
  name 'Query'

  field :allMerms, Queries::AllMerms
  field :dashboardMerms, Queries::DashboardMerms
  field :merm, Queries::GetMerm
  field :searchMerm, Queries::SearchMerm
end
