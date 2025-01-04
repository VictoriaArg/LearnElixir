defmodule GraphqlAssignmentWeb.Schema.Queries.User do
  use Absinthe.Schema.Notation

  alias GraphqlAssignmentWeb.Resolvers

  object :user_queries do
    field :user, :user do
      arg(:id, non_null(:id))

      resolve(&Resolvers.User.get/2)
    end

    field :users, list_of(:user) do
      arg(:name, :string)
      arg(:email, :string)
      arg(:before, :integer)
      arg(:after, :integer)
      arg(:first, :integer)

      resolve(&Resolvers.User.get/2)
    end

    field :users_by_preference, list_of(:user) do
      arg(:likes_emails, :boolean)
      arg(:likes_phone_calls, :boolean)
      arg(:likes_faxes, :boolean)
      arg(:before, :integer)
      arg(:after, :integer)
      arg(:first, :integer)

      resolve(&Resolvers.User.get_by_preference/2)
    end
  end
end
