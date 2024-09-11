defmodule GraphqlAssignment.Accounts do
  import Ecto.Query
  alias GraphqlAssignment.Repo
  alias GraphqlAssignment.Accounts.{User, Preference}
  alias EctoShorts.Actions

  def get_all_users(params \\ %{}) do
    Actions.all(User, params)
  end

  def get_users_by_preference(params) do
    User
    |> join(:inner, [u], p in assoc(u, :preference))
    |> where(^preference_filter_conditions(params))
    |> preload(:preference)
    |> Repo.all()
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

  defp preference_filter_conditions(params) do
    Enum.reduce(params, dynamic(true), fn {key, value}, query ->
      dynamic([u, p], field(p, ^key) == ^value and ^query)
    end)
  end
end
