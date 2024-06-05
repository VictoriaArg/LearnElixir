defmodule GraphqlAssignmentWeb.UserChannel do
  use GraphqlAssignmentWeb, :channel

  def join("users", _payload, socket) do
    {:ok, socket}
  end

  def handle_in("new_user", %{"id" => id}, socket) do
    broadcast("new_user", socket, %{"id" => id})

    {:reply, %{"accepted" => true}, socket}
  end

    def handle_in("updated_user_preferences", %{"id" => id}, socket) do
    broadcast("updated_user_preferences", socket, %{"id" => id})

    {:reply, %{"accepted" => true}, socket}
  end
end
