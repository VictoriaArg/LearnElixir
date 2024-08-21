defmodule ElixirGraphQLAssingment.Accounts.Preference do
use Ecto.Schema
import Ecto.Changeset

schema "preference" do
field :likes_emails, :boolean
field :likes_phone_calls, :boolean
field :likes_faxes, :boolean

belongs_to, :user, ElixirGraphQLAssingment.Accounts.User
end
end
