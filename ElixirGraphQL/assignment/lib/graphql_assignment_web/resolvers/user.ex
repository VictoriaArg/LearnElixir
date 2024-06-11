defmodule GraphqlAssignmentWeb.Resolvers.User do
  alias GraphqlAssignmentWeb.User

  def get(id, _) do
    id = String.to_integer(id)
    User.get(id)
  end

  def get_all(
        %{
          likes_emails: _likes_emails,
          likes_phone_calls: _likes_phone_calls,
          likes_faxes: _likes_faxes
        } = preferences,
        _
      ) do
    User.get_by_preferences(preferences)
  end

  def get_all(_, _), do: {:ok, []}

  def get_by_name(name, _), do: User.get_by_name(name)

  def create(%{id: id, name: _name, email: _email, preferences: _preferences} = params, _) do
    id = String.to_integer(id)
    params = Map.replace(params, :id, id)
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

  def update_preferences(%{user_id: id} = params, _) do
    id = String.to_integer(id)
    User.update_preferences(id, params)
  end

  def update_preferences(_params, _) do
    {:error, %{message: "argument user_id not provided"}}
  end
end
