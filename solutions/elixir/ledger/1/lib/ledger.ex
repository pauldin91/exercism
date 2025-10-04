defmodule Ledger do
  @doc """
  Format the given entries given a currency and locale
  """
  @type currency :: :usd | :eur
  @type locale :: :en_US | :nl_NL
  @type entry :: %{amount_in_cents: integer(), date: Date.t(), description: String.t()}

  @spec format_entries(currency(), locale(), list(entry())) :: String.t()
  def format_entries(currency, locale, entries) do
    header = format_header(locale)

    if entries == [] do
      header
    else
      entries =
        Enum.sort_by(entries, fn a -> {a.date.day, a.description, a.amount_in_cents} end)
        |> Enum.map(fn entry -> format_entry(currency, locale, entry) end)
        |> Enum.join("\n")

      header <> entries <> "\n"
    end
  end

  defp format_entry(currency, locale, entry) do
    date = format_date(locale, entry)

    cents = abs(div(entry.amount_in_cents, 100))
    decimal = format_cents(entry.amount_in_cents)

    delimeters =
      if locale == :en_US do
        {",", "."}
      else
        {".", ","}
      end

    whole =
      if cents < 1000 do
        cents |> to_string()
      else
        to_string(div(cents, 1000)) <>
          elem(delimeters, 0) <> to_string(rem(cents, 1000))
      end

    number = whole <> elem(delimeters, 1) <> decimal

    amount = format_currency(locale, currency, number, entry.amount_in_cents)

    description =
      if entry.description |> String.length() > 26 do
        " " <> String.slice(entry.description, 0, 22) <> "..."
      else
        " " <> String.pad_trailing(entry.description, 25, " ")
      end

    date <> "|" <> description <> " |" <> amount
  end

  def format_currency(locale, currency, number, amount_in_cents) do
    cur = "#{if(currency == :eur, do: "€", else: "$")}"

    amount =
      cond do
        locale == :en_US and amount_in_cents >= 0 ->
          "  #{cur}#{number} "

        locale == :en_US ->
          " (#{cur}#{number})"

        amount_in_cents >= 0 ->
          " #{cur} #{number} "

        true ->
          "#{cur} -#{number} "
      end

    amount |> String.pad_leading(14, " ")
  end

  def format_cents(amount) do
    amount |> abs |> rem(100) |> to_string() |> String.pad_leading(2, "0")
  end

  def format_header(locale) do
    if locale == :en_US do
      "Date       | Description               | Change       \n"
    else
      "Datum      | Omschrijving              | Verandering  \n"
    end
  end

  def format_date(locale, entry) do
    year = entry.date.year |> to_string()
    month = entry.date.month |> to_string() |> String.pad_leading(2, "0")
    day = entry.date.day |> to_string() |> String.pad_leading(2, "0")

    if locale == :en_US do
      month <> "/" <> day <> "/" <> year <> " "
    else
      day <> "-" <> month <> "-" <> year <> " "
    end
  end
end
