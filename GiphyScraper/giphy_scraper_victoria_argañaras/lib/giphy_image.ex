defmodule GiphyScraper.GiphyImage do
  @moduledoc """
  Module to define a giphy image struct.
  """

  @enforce_keys [:id, :url, :username, :title]
  defstruct [
    :id,
    :url,
    :username,
    :title
  ]
end
