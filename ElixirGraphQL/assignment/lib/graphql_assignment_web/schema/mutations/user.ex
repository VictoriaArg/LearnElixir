defmodule GraphqlAssignmentWeb.Schema.Mutations.User do
  use Absinthe.Schema.Notation

  alias GraphqlAssignmentWeb.Resolvers

  object :user_mutations do
    field :create_user, list_of(:user) do
      arg(:name, :string)
      arg(:email, :string)
      arg(:preference, :user_preference_input)

      resolve(&Resolvers.User.create/2)
    end

    field :update_user, :user do
      arg(:id, non_null(:id))
      arg(:name, :string)
      arg(:email, :string)

      resolve(&Resolvers.User.update/2)
    end

    field :update_user_preference, :user_preference do
      arg(:user_id, :id)
      arg(:likes_emails, :boolean)
      arg(:likes_phone_calls, :boolean)
      arg(:likes_faxes, :boolean)

      resolve(&Resolvers.Preference.update/2)
    end
  end
end
