defmodule GraphqlAssignmentWeb.Schema.Subscriptions.User do
  use Absinthe.Schema.Notation

  object :user_subscriptions do
    field :created_user, :user do
      trigger(:create_user, topic: fn _ -> "new_user" end)

      config(fn _, _ ->
        {:ok, topic: "new_user"}
      end)
    end

    field :updated_user_preference, :user do
      trigger(:update_user_preference, topic: fn %{id: id} -> Integer.to_string(id) end)

      config(fn args, _info ->
        {:ok, topic: args.id}
      end)
    end
  end
end
