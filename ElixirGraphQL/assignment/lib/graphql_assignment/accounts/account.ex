defmodule GraphqlAssignment.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

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
end

defmodule GraphqlAssignment.Accounts.Preference do
  use Ecto.Schema
  import Ecto.Changeset

  schema "preferences" do
    field(:likes_emails, :boolean, default: false)
    field(:likes_phone_calls, :boolean, default: false)
    field(:likes_faxes, :boolean, default: false)

    belongs_to(:user, GraphqlAssignment.Accounts.User)
    timestamps()
  end

  @required_fields [:likes_emails, :likes_phone_calls, :likes_faxes]

  def create_changeset(params) do
    changeset(%GraphqlAssignment.Accounts.Preference{}, params)
  end

  @doc false
  def changeset(preference, attrs) do
    preference
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
