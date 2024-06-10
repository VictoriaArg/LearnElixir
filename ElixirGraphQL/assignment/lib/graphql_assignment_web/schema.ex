defmodule GraphqlAssignmentWeb.Schema do
  use Absinthe.Schema
  alias GraphqlAssignmentWeb.User

  @desc "A user that has name, email, and preferences"
  object :user do
    field(:id, :id)
    field(:name, :string)
    field(:email, :string)

    field(:preferences, :user_preferences)
  end

  @desc "User preferences for emails, phone calls and faxes"
  object :user_preferences do
    field(:likes_emails, :boolean)
    field(:likes_phone_calls, :boolean)
    field(:likes_faxes, :boolean)
  end

  @desc "User preferences for emails, phone calls and faxes"
  input_object :user_preferences_input do
    field(:likes_emails, :boolean)
    field(:likes_phone_calls, :boolean)
    field(:likes_faxes, :boolean)
  end

  query do
    field :user, :user do
      arg :id, non_null(:id)

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
        _ -> User.get_by_preferences(preferences)
      _, _ ->
          {:ok, []}
      end
          )
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

  mutation do
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

  subscription do
    field :created_user, :user do
      trigger :create_user, topic: fn _ -> "new_user" end

      config(fn _, _ ->
        {:ok, topic: "new_user"}
      end)

    end

    field :updated_user_preferences, :user do
      trigger :update_user_preferences, topic: fn %{id: id} -> Integer.to_string(id) end

      config(fn args, _info ->
        {:ok, topic: args.id}
      end)
    end
  end
end
