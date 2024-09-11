defmodule GraphqlAssignmentWeb.Schema.Mutations.Preference do
  use Absinthe.Schema.Notation

  alias GraphqlAssignmentWeb.Resolvers

  object :preference_mutations do
    field :update_preference, :user_preference do
      arg(:user_id, :id)
      arg(:likes_emails, :boolean)
      arg(:likes_phone_calls, :boolean)
      arg(:likes_faxes, :boolean)

      resolve(&Resolvers.User.update_user_preference/2)
    end
  end
end
