defmodule GraphqlAssignment.Repo do
  use Ecto.Repo,
    otp_app: :graphql_assignment,
    adapter: Ecto.Adapters.Postgres
end
