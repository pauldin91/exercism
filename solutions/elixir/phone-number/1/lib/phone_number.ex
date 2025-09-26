defmodule PhoneNumber do
  @doc """
  Remove formatting from a phone number if the given number is valid. Return an error otherwise.
  """

  @spec clean(String.t()) :: {:ok, String.t()} | {:error, String.t()}

  @err_codes %{"0" => "zero", "1" => "one"}
  def clean(raw) do
    res = String.replace(raw, ~r/[\s(\+)\.-]/, "")

    only_valid =
      Regex.scan(~r/^[1]{0,1}[2-9]{1}[0-9]{2}[2-9]{1}[0-9]{2}[0-9]{4}$/, res) |> Enum.join()
        final = res |> String.reverse() |> String.slice(0, 10)

    cond do
      Regex.match?(~r/.*[^0-9]+.*/, res) ->
        {:error, "must contain digits only"}

      only_valid != "" ->
        {:ok, only_valid |> String.trim_leading("1")}

      String.length(res) < 10 ->
        {:error, "must not be fewer than 10 digits"}

      String.length(res) > 11 ->
        {:error, "must not be greater than 11 digits"}

      String.length(res) == 11 && !String.starts_with?(res, "1") ->
        {:error, "11 digits must start with 1"}

          String.at(final, 9) == "0" or String.at(final, 9) == "1" ->
            {:error, "area code cannot start with #{Map.get(@err_codes, String.at(final, 9))}"}

          String.at(final, 6) == "0" or String.at(final, 6) == "1" ->
            {:error,
             "exchange code cannot start with #{Map.get(@err_codes, String.at(final, 6))}"}

          true ->
            {:error}
  
    end
  end
end
