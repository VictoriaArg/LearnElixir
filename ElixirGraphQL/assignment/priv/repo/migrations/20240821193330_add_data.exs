defmodule GraphqlAssignment.Repo.Migrations.PopulateUsersAndPreferences do
  use Ecto.Migration

  alias GraphqlAssignment.Repo
  alias GraphqlAssignment.Accounts.{User, Preference}

  def up do
    users = [
      %{
        name: "Bill",
        email: "bill@gmail.com",
        preferences: %{
          likes_emails: false,
          likes_phone_calls: true,
          likes_faxes: true
        }
      },
      %{
        name: "Alice",
        email: "alice@gmail.com",
        preferences: %{
          likes_emails: true,
          likes_phone_calls: false,
          likes_faxes: true
        }
      },
      %{
        name: "Jill",
        email: "jill@hotmail.com",
        preferences: %{
          likes_emails: true,
          likes_phone_calls: true,
          likes_faxes: false
        }
      },
      %{
        name: "Timmmy",
        email: "timmmy@gmail.com",
        preferences: %{
          likes_emails: false,
          likes_phone_calls: false,
          likes_faxes: false
        }
      }
    ]

    Enum.each(users, fn user ->
      %{id: user_id} =
        Repo.insert!(%User{
          name: user.name,
          email: user.email
        })

      Repo.insert!(%Preference{
        likes_emails: user.preferences.likes_emails,
        likes_phone_calls: user.preferences.likes_phone_calls,
        likes_faxes: user.preferences.likes_faxes,
        user_id: user_id
      })
    end)
  end

  def down do
    Repo.delete_all(Preference)
    Repo.delete_all(User)
  end
end
