defmodule GraphqlAssignment.Accounts do
  import Ecto.Query
  alias GraphqlAssignment.Repo
  alias GraphqlAssignment.Accounts.User

  def get_all_users() do
    users = Repo.all(User)

    case users do
      nil -> {:error, %{message: "not allowed to see all users"}}
      users -> {:ok, users}
    end
  end

  # def get_user_by(:preference, params) do
  #   params
  #   |> by_preference
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

    case Repo.all(query) do
      [] ->
        {:error,
         %{
           message: "not found",
           details: %{
             {param, value}
           }
         }}

      [user] ->
        {:ok, user}
    end
  end

  def create_user(params) do
    changeset = User.changeset(%User{}, params)

    with true <- changeset.valid?,
         {:ok, user} <- Repo.insert(changeset) do
      {:ok, user}
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
    with {:ok, user} <- get_user_by(:id, id) do
      changeset = User.changeset(user, params)

      if changeset.valid? do
        Repo.update(changeset)
      else
        {:error,
         %{
           message: "not valid arguments",
           details: %{errors: changeset.errors}
         }}
      end
    end
  end

  def update_preference(id, params) do
    with {:ok, [user]} <- get_user_by(:id, id) do
      changeset = User.changeset(user, %{preference: params})

      with true <- changeset.valid? do
        {:ok, user} = Repo.update(changeset)
        {:ok, user}
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

  defp by_id(id) do
    from(u in User, where: u.id == ^id)
  end

  defp by_name(name) do
    from(u in User, where: u.name == ^name)
  end

  defp by_email(email) do
    from(u in User, where: u.email == ^email)
  end

  # def by_preference(params) do
  #   from u in User,
  #     join: p in assoc(u, :preference),
  #     where: (Enum.all?(input_prefs, fn {key, value} ->
  #       Map.get(user_prefs, key) == value
  #     end)),
  #     select: u
  # end
end
