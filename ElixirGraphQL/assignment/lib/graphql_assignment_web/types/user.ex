defmodule GraphqlAssignmentWeb.Types.User do
  use Absinthe.Schema.Notation

  @desc "A user that has name, email, and preferences"
  object :user do
    field(:id, :id)
    field(:name, :string)
    field(:email, :string)

    field(:preferences, :user_preferences)
  end

  @desc "User preferences for emails, phone calls and faxes"
  object :user_preferences do
    field(:likes_emails, :boolean)
    field(:likes_phone_calls, :boolean)
    field(:likes_faxes, :boolean)
  end

  @desc "User preferences for emails, phone calls and faxes"
  input_object :user_preferences_input do
    field(:likes_emails, :boolean)
    field(:likes_phone_calls, :boolean)
    field(:likes_faxes, :boolean)
  end
end
