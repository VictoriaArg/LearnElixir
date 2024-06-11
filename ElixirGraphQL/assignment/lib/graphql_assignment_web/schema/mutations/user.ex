defmodule GraphqlAssignmentWeb.Schema.Mutations.User do
  use Absinthe.Schema.Notation

  alias GraphqlAssignmentWeb.User

  object :user_mutations do
    field :create_user, list_of(:user) do
      arg(:id, :id)
      arg(:name, :string)
      arg(:email, :string)
      arg(:preferences, :user_preferences_input)

      resolve(fn
        %{id: id, name: _name, email: _email, preferences: _preferences} = params, _ ->
          id = String.to_integer(id)

          params = Map.replace(params, :id, id)

          User.create(params)

        _, _ ->
          {:error, %{message: "arguments not provided"}}
      end)
    end

    field :update_user, :user do
      arg(:id, :id)
      arg(:name, :string)
      arg(:email, :string)

      resolve(fn
        %{id: id, name: _name, email: _email} = params, _ ->
          id = String.to_integer(id)

          User.update(id, params)
      end)
    end

    field :update_user_preferences, :user_preferences do
      arg(:user_id, :id)
      arg(:likes_emails, :boolean)
      arg(:likes_phone_calls, :boolean)
      arg(:likes_faxes, :boolean)

      resolve(fn
        %{user_id: id} = params, _ ->
          id = String.to_integer(id)

          User.update_preferences(id, params)
      end)
    end
  end
end
