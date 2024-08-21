defmodule GraphqlAssignment.Repo.Migrations.AddPreferencesToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :preferences, references("preferences")
  end

  alter table(:preferences) do
    add :user_id, references("users")
  end
end

end
