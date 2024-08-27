defmodule GraphqlAssignment.Accounts do
  import Ecto.Query
  alias GraphqlAssignment.Repo
  alias GraphqlAssignment.Accounts.User

  def get_all_users() do
    users =
      User
      |> Repo.all()
      |> Repo.preload(:preference)

    case users do
      nil -> {:error, %{message: "not allowed to see all users"}}
      users -> {:ok, users}
    end
  end

  # def get_user_by(:preferences, params) do
  #   params
  #   |> by_preferences
  #   |> Repo.all()
  # end

  def get_user_by(param, value) do
    query =
      case param do
        :id ->
          by_id(value)

        :name ->
          by_name(value)

        :email ->
          by_email(value)
      end

    users =
      query
      |> Repo.all()
      |> Repo.preload(:preference)

    case users do
      [] ->
        {:error,
         %{
           message: "not found",
           details: %{
             {param, value}
           }
         }}

      users ->
        {:ok, users}
    end
  end

  def create_user(params) do
    changeset = User.changeset(%User{}, params)

    with true <- changeset.valid?,
         {:ok, user} <- Repo.insert(changeset) do
      {:ok, Repo.preload(user, :preference)}
    else
      {:error, changeset} ->
        {:error,
         %{
           message: "not valid arguments",
           details: %{errors: changeset.errors}
         }}
    end
  end

  def update_user(id, params) do
    with {:ok, [user]} <- get_user_by(:id, id) do
      changeset = User.changeset(user, params)

      with true <- changeset.valid?,
           {:ok, user} <- Repo.update(changeset) do
        {:ok, Repo.preload(user, :preference)}
      else
        {:error, changeset} ->
          {:error,
           %{
             message: "not valid arguments",
             details: %{errors: changeset.errors}
           }}
      end
    end
  end

  # def update_preferences() do
  # end

  defp by_id(id) do
    from(u in User, where: u.id == ^id)
  end

  defp by_name(name) do
    from(u in User, where: u.name == ^name)
  end

  defp by_email(email) do
    from(u in User, where: u.email == ^email)
  end

  # def by_preferences(params) do
  #   from u in User,
  #     join: p in assoc(u, :preference),
  #     where: (Enum.all?(input_prefs, fn {key, value} ->
  #       Map.get(user_prefs, key) == value
  #     end)),
  #     select: u
  # end
end
