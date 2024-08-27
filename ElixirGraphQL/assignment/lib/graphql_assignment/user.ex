defmodule GraphqlAssignment.User do
  alias GraphqlAssignment.Accounts

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

  @spec get_all() :: list()
  def get_all() do
    Accounts.get_all_users()
  end

  @spec get(String.t()) :: {:error, map()} | {:ok, map()}
  def get(id) do
    Accounts.get_user_by(:id, id)
  end

  @spec get_by_name(String.t()) :: {:error, map()} | {:ok, map()}
  def get_by_name(name) do
    Accounts.get_user_by(:name, name)
  end

  @spec get_by_email(String.t()) :: {:error, map()} | {:ok, map()}
  def get_by_email(email) do
    Accounts.get_user_by(:email, email)
  end

  @spec get_by_preferences(map()) :: {:error, map()} | {:ok, list()}
  def get_by_preferences(preferences) do
    case Enum.filter(@users, fn user ->
           matches_preferences?(user.preferences, preferences)
         end) do
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
  end

  @spec create(map()) :: {:error, map()} | {:ok, map()}
  def create(params) do
    Accounts.create_user(params)
  end

  @spec update(String.t(), map()) :: {:error, map()} | {:ok, map()}
  def update(id, params) do
    Accounts.update_user(id, params)
  end

  @spec update_preferences(String.t(), map()) :: {:error, map()} | {:ok, map()}
  def update_preferences(id, params) do
    case Enum.find(@users, &(&1.id === id)) do
      nil ->
        {:error, %{message: "user not found", details: %{id: id}}}

      user ->
        {_id, preferences} = Map.pop!(params, :user_id)
        updated_user = Map.merge(user, preferences)
        {:ok, updated_user}
    end
  end

  defp matches_preferences?(user_prefs, input_prefs) do
    Enum.all?(input_prefs, fn {key, value} ->
      Map.get(user_prefs, key) == value
    end)
  end
end
