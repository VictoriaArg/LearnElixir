defmodule GraphqlAssignment.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias GraphqlAssignment.Accounts.Preference

  schema "users" do
    field(:name, :string)
    field(:email, :string)

    has_one(:preference, Preference, on_replace: :delete)
    timestamps()
  end

  @available_fields [:name, :email]
  @required_fields [:name, :email]

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @available_fields)
    |> validate_required(@required_fields)
    |> cast_assoc(:preference, with: &Preference.changeset/2)
  end
end
