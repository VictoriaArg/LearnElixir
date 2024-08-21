defmodule ElixirGraphQLAssingment.Accounts.User do
use Ecto.Schema
import Ecto.Changeset

schema "user" do
field :name, :string
field :email, :string

has_one :preference, ElixirGraphQLAssingment.Accounts.Preference
end

end
