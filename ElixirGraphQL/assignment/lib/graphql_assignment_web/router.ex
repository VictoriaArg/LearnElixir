defmodule GraphqlAssignmentWeb.Router do
  use GraphqlAssignmentWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/" do
    pipe_through(:api)

    forward("/graphql", Absinthe.Plug, schema: GraphqlAssignmentWeb.Schema)

    if Mix.env() === :dev do
      forward("/graphiql", Absinthe.Plug.GraphiQL,
        schema: GraphqlAssignmentWeb.Schema,
        socket: GraphqlAssignmentWeb.UserSocket,
        interface: :playground
      )
    end
  end
end
