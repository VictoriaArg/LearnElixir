defmodule GraphqlAssignmentWeb.Types.User do
  use Absinthe.Schema.Notation

  @desc "A user that has name, email, and preference"
  object :user do
    field(:id, :id)
    field(:name, :string)
    field(:email, :string)

    field(:preference, :user_preference)
  end

  @desc "User preference for emails, phone calls and faxes"
  object :user_preference do
    field(:likes_emails, :boolean)
    field(:likes_phone_calls, :boolean)
    field(:likes_faxes, :boolean)
  end

  @desc "User preference for emails, phone calls and faxes"
  input_object :user_preference_input do
    field(:likes_emails, :boolean)
    field(:likes_phone_calls, :boolean)
    field(:likes_faxes, :boolean)
  end
end
