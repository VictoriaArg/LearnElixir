# defmodule GraphqlAssignment.User do
#  alias GraphqlAssignment.Accounts

#  @spec get(String.t()) :: {:error, map()} | {:ok, map()}
#  def get(params) do
# Accounts.find_user(params)
#  end

#  @spec get(map()) :: {:error, map()} | {:ok, list()}
#  def get_by_preference(%{preference: preference}) do
# case Accounts.get_users_by_preference(preference) do
# {:error, error} -> {:error, %{message: error}}
# users -> {:ok, users}
# end
#  end

#  @spec get_all() :: list()
#  def get_all(params \\ %{}) do
# users = Accounts.get_all_users(params)
# {:ok, users}
#  end

#  @spec create(map()) :: {:error, map()} | {:ok, map()}
#  def create(params) do
# Accounts.create_user(params)
#  end

#  @spec update(String.t(), map()) :: {:error, map()} | {:ok, map()}
#  def update(id, params) do
# Accounts.update_user(id, params)
#  end

#  @spec update_preference(String.t(), map()) :: {:error, map()} | {:ok, map()}
#  def update_preference(user_id, params) do
# Accounts.update_preference(user_id, params)
#  end
#  end
