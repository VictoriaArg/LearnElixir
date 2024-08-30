defmodule GraphqlAssignmentWeb.Schema.Subscriptions.Preference do
  use Absinthe.Schema.Notation

  object :preference_subscriptions do
    field :updated_preference, :user_preference do
      trigger(:update_preferences, topic: fn %{user_id: id} -> Integer.to_string(id) end)

      config(fn args, _info ->
        {:ok, topic: args.id}
      end)
    end
  end
end
