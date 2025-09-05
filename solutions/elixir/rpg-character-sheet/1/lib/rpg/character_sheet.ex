defmodule RPG.CharacterSheet do
  def welcome() do
    # Please implement the welcome/0 function
    IO.puts("Welcome! Let's fill out your character sheet together.")
    :ok
  end

  def ask_name() do
    # Please implement the ask_name/0 function
    s = IO.gets("What is your character's name?\n")
    String.trim(s)
  end

  def ask_class() do
    # Please implement the ask_class/0 function
    s=IO.gets("What is your character's class?\n")
    String.trim(s)
  end

  def ask_level() do
    # Please implement the ask_level/0 function
     s = IO.gets("What is your character's level?\n") 
     s |> String.trim() |> String.to_integer()
  end

  def run() do
    # Please implement the run/0 function
    welcome()
    name = ask_name()
    cl = ask_class()
    lvl = ask_level()
    ma = %{class: cl, level: lvl, name: name}
    IO.puts("Your character: " <> inspect(ma))
    ma
  end
end
