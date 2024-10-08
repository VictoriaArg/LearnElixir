defmodule GraphqlAssignmentWeb.UserSocket do
  use Phoenix.Socket

  use Absinthe.Phoenix.Socket, schema: GraphqlAssignmentWeb.Schema

  channel("users", GraphqlAssignmentWeb.UserChannel)

  def connect(_params, socket, _connect_info) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
