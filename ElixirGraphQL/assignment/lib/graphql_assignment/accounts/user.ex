defmodule GraphqlAssignment.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "users" do
    field(:name, :string)
    field(:email, :string)

    has_one(:preference, GraphqlAssignment.Accounts.Preference, on_replace: :delete)
    timestamps()
  end

  @available_fields [:name, :email]

  def create_changeset(params) do
    changeset(%GraphqlAssignment.Accounts.User{}, params)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @available_fields)
    |> validate_required(@available_fields)
    |> cast_assoc(:preference, with: &GraphqlAssignment.Accounts.Preference.changeset/2)
  end

  def by_preference(params) do
    query =
      from(u in GraphqlAssignment.Accounts.User,
        join: p in assoc(u, :preference),
        as: :preference
      )

    params
    |> Enum.reduce(query, fn {key, value}, query ->
      where(query, [u, preference: p], field(p, ^key) == ^value)
    end)
    |> preload(:preference)
  end
end
