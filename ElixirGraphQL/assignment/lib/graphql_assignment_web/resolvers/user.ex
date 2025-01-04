defmodule GraphqlAssignmentWeb.Resolvers.User do
  alias GraphqlAssignment.Accounts

  def get(%{id: id}, _) do
    id = String.to_integer(id)
    Accounts.get_user(%{id: id})
  end

  def get(params, _), do: Accounts.get_all_users(params)

  def get_by_preference(params, _) do
    {preference, filters} = Map.split(params, [:likes_emails, :likes_faxes, :likes_phone_calls])
    Accounts.get_users_by_preference(preference, filters)
  end

  def create(%{name: _name, email: _email, preference: _preference} = params, _) do
    Accounts.create_user(params)
  end

  def create(_params, _) do
    {:error, %{message: "arguments not provided"}}
  end

  def update(%{id: id} = params, _) do
    id = String.to_integer(id)
    Accounts.update_user(id, params)
  end

  def update(_params, _) do
    {:error, %{message: "arguments not provided"}}
  end

  def update_preference(%{user_id: id} = params, _) do
    id = String.to_integer(id)
    Accounts.update_preference(id, params)
  end

  def update_preference(_params, _) do
    {:error, %{message: "argument user_id not provided"}}
  end
end
