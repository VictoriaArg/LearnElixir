defmodule GraphqlAssignmentWeb.Schema do
  use Absinthe.Schema

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

  @users [
    %{
      id: 1,
      name: "Bill",
      email: "bill@gmail.com",
      preferences: %{
        likes_emails: false,
        likes_phone_calls: true,
        likes_faxes: true
      }
    },
    %{
      id: 2,
      name: "Alice",
      email: "alice@gmail.com",
      preferences: %{
        likes_emails: true,
        likes_phone_calls: false,
        likes_faxes: true
      }
    },
    %{
      id: 3,
      name: "Jill",
      email: "jill@hotmail.com",
      preferences: %{
        likes_emails: true,
        likes_phone_calls: true,
        likes_faxes: false
      }
    },
    %{
      id: 6,
      name: "Timmmy",
      email: "timmmy@gmail.com",
      preferences: %{
        likes_emails: false,
        likes_phone_calls: false,
        likes_faxes: false
      }
    }
  ]

  query do
    field :user, :user do
      arg :id, non_null(:id)

      resolve(fn %{id: id}, _ ->
        id = String.to_integer(id)

        case Enum.find(@users, &(&1.id === id)) do
          nil -> {:error, %{message: "not found", details: %{id: id}}}
          user -> {:ok, user}
        end
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
          case Enum.filter(
                 @users,
                 &(&1.preferences === preferences)
               ) do
            [] ->
              {:error,
               %{
                 message: "not found",
                 details: %{
                   preferences: preferences
                 }
               }}

            users ->
              {:ok, users}
          end

        _, _ ->
          {:ok, @users}
      end)
    end

    field :users_by_name, list_of(:user) do
      arg(:name, non_null(:string))

      resolve(fn
        %{name: name}, _ ->
          case Enum.filter(
                 @users,
                 &(&1.name === name)
               ) do
            [] ->
              {:error,
               %{
                 message: "not found",
                 details: %{
                   name: name
                 }
               }}

            users ->
              {:ok, users}
          end

        _, _ ->
          {:ok, @users}
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
        %{id: id, name: name, email: email, preferences: preferences}, _ ->
          id = String.to_integer(id)

          case Enum.find(@users, &(&1.id === id)) do
            nil ->
              with {:ok, new_user} <- create_new_user(id, name, email, preferences) do
              {:ok, @users ++ [new_user]}
              end
            _user ->
              {:error, %{message: "id already in use", details: %{id: id}}}
          end

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

          case Enum.find(@users, &(&1.id === id)) do
            nil ->
              {:error, %{message: "user not found", details: %{id: id}}}

            user ->
              {:ok, Map.merge(user, params)}
          end
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

          case Enum.find(@users, &(&1.id === id)) do
            nil ->
              {:error, %{message: "user not found", details: %{id: id}}}

            user ->
              {_id, preferences} = Map.pop!(params, :user_id)
              updated_user = Map.merge(user, preferences)
              {:ok, updated_user}
          end
      end)
    end
  end

  subscription do
    field :created_user, :user do
      config(fn _, _ ->
        {:ok, topic: "new_user"}
      end)

      trigger :create_user, topic: fn _ -> "new_user" end
    end

    field :updated_user_preferences, :user do
      config(fn args, _info ->
        {:ok, topic: args.id}
      end)

      trigger :update_user_preferences, topic: fn %{id: id} -> {:ok, topic: id} end

    end
  end

  defp create_new_user(id, name, email, preferences) do
    {:ok, Map.new(id: id, name: name, email: email, preferences: preferences)}
  end
end
