defmodule CircularBuffer do
  @moduledoc """
  An API to a stateful process that fills and empties a circular buffer
  """

  @doc """
  Create a new buffer of a given capacity
  """

  defstruct [:buffer, :capacity, :starting_at]
  @spec new(capacity :: integer) :: {:ok, pid}
  def new(capacity) do
    GenServer.start_link(__MODULE__, capacity)
  end

  @doc """
  Read the oldest entry in the buffer, fail if it is empty
  """
  @spec read(buffer :: pid) :: {:ok, any} | {:error, atom}
  def read(buffer) do
    GenServer.call(buffer, :read)
  end

  @doc """
  Write a new item in the buffer, fail if is full
  """
  @spec write(buffer :: pid, item :: any) :: :ok | {:error, atom}
  def write(pid, item) do
    buffer = GenServer.call(pid, :get_buffer)

    cond do
      Enum.count(buffer.buffer) == buffer.capacity ->
        {:error, :full}

      true ->
        GenServer.cast(pid, {:write, item})
    end
  end

  @doc """
  Write an item in the buffer, overwrite the oldest entry if it is full
  """
  @spec overwrite(buffer :: pid, item :: any) :: :ok
  def overwrite(pid, item) do
    buffer = GenServer.call(pid, :get_buffer)

    cond do
      Enum.count(buffer.buffer) < buffer.capacity ->
        GenServer.cast(pid, {:write, item})

      true ->
        GenServer.cast(pid, {:overwrite, item})
    end
  end

  @doc """
  Clear the buffer
  """
  @spec clear(buffer :: pid) :: :ok
  def clear(buffer) do
    GenServer.call(buffer, :clear)
  end

  @impl true
  def init(initial) do
    {:ok, %CircularBuffer{buffer: [], capacity: initial}}
  end

  @impl true
  def handle_call(:read, _from, buffer) do
    cond do
      buffer.starting_at == nil or buffer.buffer == [] ->
        {:reply, {:error, :empty}, []}

      true ->
        [h | t] = buffer.buffer

        cond do
          t == [] ->
            {:reply, {:ok, h}, %CircularBuffer{buffer: [], capacity: buffer.capacity}}

          true ->
            {:reply, {:ok, h}, %CircularBuffer{buffer | starting_at: hd(t), buffer: t}}
        end
    end
  end

  def handle_call(:get_buffer, _from, buffer) do
    {:reply, buffer, buffer}
  end

  def handle_call(:clear, _from, buffer) do
    {:reply, :ok, %CircularBuffer{buffer | starting_at: nil, buffer: []}}
  end

  @impl true
  def handle_cast({:write, item}, buffer) do
    cond do
      buffer.starting_at == nil or buffer.buffer == [] ->
        {:noreply, %CircularBuffer{buffer: [item], starting_at: item, capacity: buffer.capacity}}

      true ->
        {:noreply, %CircularBuffer{buffer | buffer: buffer.buffer ++ [item]}}
    end
  end

  def handle_cast({:overwrite, item}, buffer) do
    {left, right} = Enum.split_with(buffer.buffer, fn s -> s == buffer.starting_at end)

    oldest =
      cond do
        right != [] -> hd(right)
        left != [] -> hd(left)
        true -> item
      end

    {:noreply,
     %CircularBuffer{
       buffer
       | starting_at: oldest,
         buffer: (left -- [buffer.starting_at]) ++ right ++ [item]
     }}
  end
end
