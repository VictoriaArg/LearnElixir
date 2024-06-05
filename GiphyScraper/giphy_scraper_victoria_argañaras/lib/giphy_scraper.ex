defmodule GiphyScraper do
  @moduledoc """
  GiphyScraper searches for gifs at Giphy.
  """

  def search(search_value) when is_binary(search_value) do
    if valid_search_value?(search_value) do
      url = build_url(search_value)

      get_gifs(url)
    else
      search(:not_valid)
    end
  end

  def search(_search_value),
    do: "Search only works with Strings between 1 and 50 characters, try again"

  defp get_gifs(url) do
    req = Finch.build(:get, url, [])

    with {:ok,
          %Finch.Response{
            status: 200,
            body: body
          }} <- Finch.request(req, MyFinch) do
      {:ok, %{"data" => gifs_data}} = Jason.decode(body)

      Enum.map(gifs_data, fn gif ->
        %GiphyScraper.GiphyImage{
          id: gif["id"],
          url: gif["url"],
          username: gif["username"],
          title: gif["title"]
        }
      end)
    end
  end

  defp valid_search_value?(search_value),
    do: String.length(search_value) > 0 && String.length(search_value) <= 50

  defp build_url(search_value) do
    "http://api.giphy.com/v1/gifs/search?api_key=#{get_api_key()}&q=#{search_value}"
  end

  defp get_api_key, do: System.get_env("GIPHY_API_KEY")
end
