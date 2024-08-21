defmodule GraphqlAssignment.Repo.Migrations.ChangePreferenceFieldName do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :preferences
      add :preferences_id, references("preferences")
  end
  end
end
