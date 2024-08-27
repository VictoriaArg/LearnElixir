defmodule GraphqlAssignmentWeb.Schema.Queries.User do
  use Absinthe.Schema.Notation

  alias GraphqlAssignmentWeb.Resolvers

  object :user_queries do
    field :user, :user do
      arg(:id, non_null(:id))

      resolve(&Resolvers.User.get/2)
    end

    field :users_with_preferences, list_of(:user) do
      arg(:likes_emails, :boolean)
      arg(:likes_phone_calls, :boolean)
      arg(:likes_faxes, :boolean)

      resolve(&Resolvers.User.get_by_preferences/2)
    end

    field :all_users, list_of(:user) do
      resolve(&Resolvers.User.get_all/2)
    end

    field :users_by_name, list_of(:user) do
      arg(:name, non_null(:string))

      resolve(&Resolvers.User.get_by_name/2)
    end

    field :users_by_email, list_of(:user) do
      arg(:email, non_null(:string))

      resolve(&Resolvers.User.get_by_email/2)
    end
  end
end
