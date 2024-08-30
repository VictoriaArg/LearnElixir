defmodule GraphqlAssignment.Preference do
  alias GraphqlAssignment.Accounts

 @spec update(String.t(), map()) :: {:error, map()} | {:ok, map()}
  def update(user_id, params) do
    Accounts.update_preference(user_id, params)
  end
end
