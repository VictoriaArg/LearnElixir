# seeds.exs

alias GraphqlAssignment.Repo
alias GraphqlAssignment.Accounts.User

# Define the list of users with their preference
users = [
  %{
    name: "Bill",
    email: "bill@gmail.com",
    preference: %{
      likes_emails: false,
      likes_phone_calls: true,
      likes_faxes: true
    }
  },
  %{
    name: "Alice",
    email: "alice@gmail.com",
    preference: %{
      likes_emails: true,
      likes_phone_calls: false,
      likes_faxes: true
    }
  },
  %{
    name: "Jill",
    email: "jill@hotmail.com",
    preference: %{
      likes_emails: true,
      likes_phone_calls: true,
      likes_faxes: false
    }
  },
  %{
    name: "Timmmy",
    email: "timmmy@gmail.com",
    preference: %{
      likes_emails: false,
      likes_phone_calls: false,
      likes_faxes: false
    }
  }
]

# Iterate over the users and insert each one into the database
for user_attrs <- users do
  %User{}
  |> User.changeset(user_attrs)
  |> Repo.insert()
end
