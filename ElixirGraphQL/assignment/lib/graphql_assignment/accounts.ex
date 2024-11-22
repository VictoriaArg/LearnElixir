defmodule GraphqlAssignment.Accounts do
  alias GraphqlAssignment.Accounts.{User, Preference}
  alias EctoShorts.Actions

  def get_all_users(params \\ %{}) do
    Actions.all(User, params)
  end

  def get_users_by_preference(params) do
    User.get_by_preference(params)
  end

  def find_user(params) do
    Actions.find(User, params)
  end

  def update_user(id, params) do
    Actions.update(User, id, params)
  end

  def create_user(params) do
    Actions.create(User, params)
  end

  def update_preference(user_id, params) do
    Actions.find_and_update(Preference, %{user_id: user_id}, params)
  end
end
