defmodule RssFeed do
  use HTTPoison.Base

  def get_feed do
    "<xml></xml>"
  end

  def get_feed(url) do
    try do
      HTTPoison.start
      HTTPoison.get!(url).body
    rescue
      e in HTTPoison.Error -> e
      ""
    end
  end
end
