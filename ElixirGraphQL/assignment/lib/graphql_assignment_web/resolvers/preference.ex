defmodule GraphqlAssignmentWeb.Resolvers.Preference do
  alias GraphqlAssignment.Preference

def update(%{user_id: id} = params, _) do
    id = String.to_integer(id)
    preference = Map.delete(params, :user_id)
    Preference.update(id, %{preference: preference})
  end

  def update(_params, _) do
    {:error, %{message: "argument user_id not provided"}}
  end
end
