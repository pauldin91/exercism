defmodule Grep do
  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()
  def grep(pattern, flags, files) do
    get_lines(files)
    |>Enum.filter(fn s ->
      comparison(flags,
        String.split(s, ":") |> Enum.reverse() |> hd |> String.trim_trailing("\n"),
        pattern
      )
    end)
    |> Enum.map(fn s -> numbers(flags, s) end)
    |> Enum.map(fn s -> file_output(flags, s, files) end)
    |> Enum.uniq()
    |> Enum.join()
    |> String.replace("\n\n", "\n")
  end

  def get_lines(files) do
    Enum.map(files, fn f ->
      {:ok, content} = File.read(f)
      {f, content}
    end)
    |> Enum.map(fn {n, s} ->
      {n, s |> String.split("\n") |> Enum.with_index()}
    end)
    |> Enum.reduce([], fn x, acc ->
      acc ++
        for(
          n <- elem(x, 1),
          do:
            cond do
              elem(n, 0) != "" -> elem(x, 0) <> ":" <> "#{elem(n, 1) + 1}:" <> elem(n, 0) <> "\n"
              true -> ""
            end
        )
    end)
    |> Enum.filter(fn r -> !String.ends_with?(r, ":") or String.trim(r) != "" end)
  end

  def file_output(flags, s, files) do
    cond do
      Enum.member?(flags, "-l") -> (String.split(s, ":") |> hd) <> "\n"
      Enum.count(files) > 1 -> s
      true -> String.replace(s, ~r/^(.*\.txt\:)/, "")
    end
  end

  def comparison(flags, s1, s2) do
    {t1,t2} = cond do
        Enum.member?(flags, "-i") -> {String.downcase(s1),String.downcase(s2)}
        true -> {s1,s2}
    end
    res =
      cond do
        Enum.member?(flags, "-x") -> t1 == t2
        true -> String.contains?(t1, t2)
      end

    cond do
      Enum.member?(flags, "-v") -> !res
      true -> res
    end
  end

  def numbers(flags, s) do
    cond do
      Enum.member?(flags, "-n") -> s
      true -> String.replace(s, ~r/:[0-9]*:/, ":")
    end
  end
end
