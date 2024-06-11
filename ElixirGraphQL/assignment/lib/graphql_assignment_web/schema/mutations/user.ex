defmodule GraphqlAssignmentWeb.Schema.Mutations.User do
  use Absinthe.Schema.Notation

  alias GraphqlAssignmentWeb.Resolvers

  object :user_mutations do
    field :create_user, list_of(:user) do
      arg(:id, :id)
      arg(:name, :string)
      arg(:email, :string)
      arg(:preferences, :user_preferences_input)

      resolve(&Resolvers.User.create/2)
    end

    field :update_user, :user do
      arg(:id, :id)
      arg(:name, :string)
      arg(:email, :string)

      resolve(&Resolvers.User.update/2)
    end

    field :update_user_preferences, :user_preferences do
      arg(:user_id, :id)
      arg(:likes_emails, :boolean)
      arg(:likes_phone_calls, :boolean)
      arg(:likes_faxes, :boolean)

      resolve(&Resolvers.User.update_preferences/2)
    end
  end
end
