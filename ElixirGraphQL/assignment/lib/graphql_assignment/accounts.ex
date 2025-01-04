defmodule GraphqlAssignment.Accounts do
  alias GraphqlAssignment.Accounts.{User, Preference}
  alias EctoShorts.Actions

  @spec get_user(map()) :: {:error, map()} | {:ok, map()}
  def get_user(params \\ %{}) do
    Actions.find(User, params)
  end

  @spec get_all_users(map()) :: {:error, map()} | {:ok, list()}
  def get_all_users(params \\ %{}) do
    users = Actions.all(User, params)
    {:ok, users}
  end

  @spec get_users_by_preference(map(), map()) :: {:error, map()} | {:ok, list()}
  def get_users_by_preference(preference, filters) do
    query = User.by_preference(preference)

    case Actions.all(query, filters) do
      {:error, error} -> {:error, %{message: error}}
      users -> {:ok, users}
    end
  end

  @spec update_user(integer(), map()) :: {:error, map()} | {:ok, map()}
  def update_user(id, params) do
    Actions.update(User, id, params)
  end

  @spec create_user(map()) :: {:error, map()} | {:ok, map()}
  def create_user(params) do
    Actions.create(User, params)
  end

  @spec update_preference(integer(), map()) :: {:error, map()} | {:ok, map()}
  def update_preference(user_id, params) do
    Actions.find_and_update(Preference, %{user_id: user_id}, params)
  end
end
