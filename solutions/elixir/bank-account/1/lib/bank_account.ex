defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank account, making it available for further operations.
  """
  @spec open() :: account
  def open() do
    {:ok, pid} = Agent.start_link(fn -> %{account: 0} end)
    pid
  end

  @doc """
  Close the bank account, making it unavailable for further operations.
  """
  @spec close(account) :: any
  def close(account) do
    Agent.stop(account)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer | {:error, :account_closed}
  def balance(account) do
    alive = Process.alive?(account)

    cond do
      alive -> Map.get(Agent.get(account, & &1), :account)
      true -> {:error, :account_closed}
    end
  end

  @doc """
  Add the given amount to the account's balance.
  """
  @spec deposit(account, integer) :: :ok | {:error, :account_closed | :amount_must_be_positive}
  def deposit(account, amount) do
    alive = Process.alive?(account)

    cond do
      amount <= 0 ->
        {:error, :amount_must_be_positive}

      alive ->
        Agent.get_and_update(account, fn m ->
          Map.get_and_update(m, :account, fn _ -> {:account, Map.get(m, :account, 0) + amount} end)
        end)

        :ok

      true ->
        {:error, :account_closed}
    end
  end

  @doc """
  Subtract the given amount from the account's balance.
  """
  @spec withdraw(account, integer) ::
          :ok | {:error, :account_closed | :amount_must_be_positive | :not_enough_balance}
  def withdraw(account, amount) do
    alive = Process.alive?(account)

    cond do
      amount <= 0 ->
        {:error, :amount_must_be_positive}

      !alive ->
        {:error, :account_closed}

      true ->
        Agent.get_and_update(account, fn state ->
          current_balance = Map.get(state, :account, 0)

          cond do
            current_balance >= amount ->
              {:ok, Map.put(state, :account, current_balance - amount)}

            true ->
              {{:error, :not_enough_balance}, state}
          end
        end)
    end
  end
end
