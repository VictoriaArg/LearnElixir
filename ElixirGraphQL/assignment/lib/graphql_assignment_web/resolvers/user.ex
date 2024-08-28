defmodule GraphqlAssignmentWeb.Resolvers.User do
  alias GraphqlAssignment.User

  def get(%{id: id}, _) do
    id = String.to_integer(id)
    User.get(id)
  end

  def get_all(%{}, _) do
    User.get_all()
  end

  def get_by_preference(preference, _) do
    User.get_by_preference(preference)
  end

  def get_by_name(%{name: name}, _), do: User.get_by_name(name)

  def get_by_email(%{email: email}, _), do: User.get_by_email(email)

  def create(%{name: _name, email: _email, preference: _preference} = params, _) do
    User.create(params)
  end

  def create(_params, _) do
    {:error, %{message: "arguments not provided"}}
  end

  def update(%{id: id, name: _name, email: _email} = params, _) do
    id = String.to_integer(id)
    User.update(id, params)
  end

  def update(_params, _) do
    {:error, %{message: "arguments not provided"}}
  end

  def update_preference(%{user_id: id} = params, _) do
    id = String.to_integer(id)
    User.update_preference(id, params)
  end

  def update_preference(_params, _) do
    {:error, %{message: "argument user_id not provided"}}
  end
end
