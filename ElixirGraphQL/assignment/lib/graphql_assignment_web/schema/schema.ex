defmodule GraphqlAssignmentWeb.Schema do
  use Absinthe.Schema

  import_types(GraphqlAssignmentWeb.Types.User)
  import_types(GraphqlAssignmentWeb.Schema.Queries.User)
  import_types(GraphqlAssignmentWeb.Schema.Mutations.User)
  import_types(GraphqlAssignmentWeb.Schema.Mutations.Preference)
  import_types(GraphqlAssignmentWeb.Schema.Subscriptions.User)
  import_types(GraphqlAssignmentWeb.Schema.Subscriptions.Preference)

  query do
    import_fields(:user_queries)
  end

  mutation do
    import_fields(:user_mutations)
    import_fields(:preference_mutations)
  end

  subscription do
    import_fields(:user_subscriptions)
    import_fields(:preference_subscriptions)
  end

  def context(ctx) do
    source = Dataloader.Ecto.new(GraphqlAssignment.Repo)
    dataloader = Dataloader.add_source(Dataloader.new(), GraphqlAssignment.Accounts, source)
    Map.put(ctx, :loader, dataloader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
