defmodule React do
  @opaque cells :: pid

  @type cell :: {:input, String.t(), any} | {:output, String.t(), [String.t()], fun()}

  @doc """
  Start a reactive system
  """
  @spec new(cells :: [cell]) :: {:ok, pid}
  def new(cells) do
    GenServer.start_link(__MODULE__, cells)
  end

  @doc """
  Return the value of an input or output cell
  """
  @spec get_value(cells :: pid, cell_name :: String.t()) :: any()
  def get_value(cells, cell_name) do
    GenServer.call(cells, {:get, cell_name})
  end

  @doc """
  Set the value of an input cell
  """
  @spec set_value(cells :: pid, cell_name :: String.t(), value :: any) :: :ok
  def set_value(cells, cell_name, value) do
    GenServer.cast(cells, {:set, cell_name, value})
  end

  @doc """
  Add a callback to an output cell
  """
  @spec add_callback(
          cells :: pid,
          cell_name :: String.t(),
          callback_name :: String.t(),
          callback :: fun()
        ) :: :ok
  def add_callback(cells, cell_name, callback_name, callback) do
    GenServer.cast(cells, {:add_callback, cell_name, callback_name, callback})
  end

  @doc """
  Remove a callback from an output cell
  """
  @spec remove_callback(cells :: pid, cell_name :: String.t(), callback_name :: String.t()) :: :ok
  def remove_callback(cells, cell_name, callback_name) do
    GenServer.cast(cells, {:remove_callback, cell_name, callback_name})
  end

  @impl true
  def init(initial) do
    {:ok, initial}
  end

  @impl true
  def handle_call({:get, value}, _from, buffer) do
    {:reply, reval(buffer, value), buffer}
  end

  def reval(buffer, value) do
    result =
      Enum.find(buffer, nil, fn el ->
        elem(el, 1) == value
      end)

    cond do
      result == nil ->
        result

      elem(result, 0) == :input ->
        elem(result, 2)

      true ->
        apply(elem(result, 3), elem(result, 2) |> Enum.map(&reval(buffer, &1)))
    end
  end

  @impl true
  def handle_cast({:set, cell_name, value}, buffer) do
    map =
      buffer
      |> Enum.map(fn el ->
        cond do
          elem(el, 0) == :input and elem(el, 1) == cell_name -> {:input, cell_name, value}
          true -> el
        end
      end)

    Enum.filter(map, fn el -> elem(el, 0) == :output and is_binary(elem(el, 2)) end)
    |> Enum.each(fn el ->
      cur = reval(map, elem(el, 1))
      prev = reval(buffer, elem(el, 1))

      cond do
        cur != prev ->
          apply(elem(el, 3), [elem(el, 2), reval(map, elem(el, 1))])

        true ->
          :ok
      end
    end)

    {:noreply, map}
  end

  def handle_cast({:add_callback, cell_name, callback_name, callback}, buffer) do
    {:noreply, buffer ++ [{:output, cell_name, callback_name, callback}]}
  end

  def handle_cast({:remove_callback, cell_name, callback_name}, buffer) do
    map =
      buffer
      |> Enum.reject(fn el ->
        elem(el, 0) == :output and elem(el, 1) == cell_name and callback_name == elem(el, 2)
      end)

    {:noreply, map}
  end
end
