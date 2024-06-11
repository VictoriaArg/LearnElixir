defmodule GraphqlAssignmentWeb.Schema.Queries.User do
  use Absinthe.Schema.Notation

  alias GraphqlAssignmentWeb.User

  object :user_queries do
    field :user, :user do
      arg(:id, non_null(:id))

      resolve(fn %{id: id}, _ ->
        id = String.to_integer(id)
        User.get(id)
      end)
    end

    field :users, list_of(:user) do
      arg(:likes_emails, :boolean)
      arg(:likes_phone_calls, :boolean)
      arg(:likes_faxes, :boolean)

      resolve(fn
        %{
          likes_emails: _likes_emails,
          likes_phone_calls: _likes_phone_calls,
          likes_faxes: _likes_faxes
        } = preferences,
        _ ->
          User.get_by_preferences(preferences)

        _, _ ->
          {:ok, []}
      end)
    end

    field :users_by_name, list_of(:user) do
      arg(:name, non_null(:string))

      resolve(fn
        %{name: name}, _ ->
          User.get_by_name(name)

        _, _ ->
          {:error,
           %{
             message: "name not provided"
           }}
      end)
    end
  end
end
