defmodule GraphqlAssignmentWeb.Schema do
  use Absinthe.Schema

  import_types(GraphqlAssignmentWeb.Types.User)
  import_types(GraphqlAssignmentWeb.Schema.Queries.User)
  import_types(GraphqlAssignmentWeb.Schema.Mutations.User)
  import_types(GraphqlAssignmentWeb.Schema.Subscriptions.User)

  query do
    import_fields(:user_queries)
  end

  mutation do
    import_fields(:user_mutations)
  end

  subscription do
    import_fields(:user_subscriptions)
  end
end
