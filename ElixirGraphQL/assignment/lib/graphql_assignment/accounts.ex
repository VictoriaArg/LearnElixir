defmodule GraphqlAssignment.Accounts do
  import Ecto.Query
  alias GraphqlAssignment.Repo
  alias GraphqlAssignment.Accounts.User

  def get_all_users() do
    Repo.all(User)
  end

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

    Repo.all(query)
  end

  # def create_user() do
  # end

  # def update_user() do
  # end

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
end
