defmodule GraphqlAssignment.Accounts.Preference do
  use Ecto.Schema
  import Ecto.Changeset
  alias GraphqlAssignment.Accounts.User

  schema "preferences" do
    field(:likes_emails, :boolean, default: false)
    field(:likes_phone_calls, :boolean, default: false)
    field(:likes_faxes, :boolean, default: false)

    belongs_to(:user, User)
    timestamps()
  end

  @required_fields [:likes_emails, :likes_phone_calls, :likes_faxes]

  @doc false
  def changeset(preference, attrs) do
    preference
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
