defmodule GraphqlAssignmentWeb.Schema.Subscriptions.User do
  use Absinthe.Schema.Notation

  object :user_subscriptions do
    field :created_user, :user do
      trigger(:create_user, topic: fn _ -> "new_user" end)

      config(fn _, _ ->
        {:ok, topic: "new_user"}
      end)
    end
  end

  object :preference_subscriptions do
    field :updated_preference, :user_preference do
      arg(:id, non_null(:id))

      trigger(:update_preference,
        topic: fn %{user_id: id} ->
          Integer.to_string(id)
        end
      )

      config(fn args, _info ->
        {:ok, topic: args.id}
      end)
    end
  end
end
