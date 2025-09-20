defmodule TakeANumberDeluxe do
  # Client API

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(init_arg) do
    # Please implement the start_link/1 function
    {status,state} = TakeANumberDeluxe.State.new(Keyword.get(init_arg,:min_number),Keyword.get(init_arg,:max_number),Keyword.get(init_arg,:auto_shutdown_timeout,:infinity))
    cond do
      :ok==status -> GenServer.start_link(__MODULE__, state,name: Keyword.get(init_arg,:registered_name))
      true->{status,state} 
    end
    
  end

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(machine) do
    # Please implement the report_state/1 function
    GenServer.call(machine,:report)
  end

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine) do
    state = report_state(machine)

    case TakeANumberDeluxe.State.queue_new_number(state) do
      {:ok, new_number, new_state} ->
        GenServer.cast(machine, {:enqueue, new_state})
        {:ok, new_number}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil) do
    # Please implement the serve_next_queued_number/2 function
    state = report_state(machine)
    case TakeANumberDeluxe.State.serve_next_queued_number(state,priority_number) do
      {:ok,num,state} -> 
          GenServer.cast(machine, {:serve, state})
          {:ok,num} 
      {:error,reason} ->{:error,reason}
    end
  end

  @spec reset_state(pid()) :: :ok
  def reset_state(machine) do
    # Please implement the reset_state/1 function
    state = report_state(machine)
    GenServer.cast(machine,{:reset,state})
  end

  # Server callbacks

  # Please implement the necessary callbacks
  @impl true
  def init(initial), do: {:ok, initial,initial.auto_shutdown_timeout}

  @impl true
  def handle_call(:report, _from, machine) do
    {:reply, machine, machine,machine.auto_shutdown_timeout}
  end

  @impl true
  def handle_info(reason, state) do
    
    case reason do
      :timeout -> {:stop, :normal, state}
      _ -> {:noreply,state,state.auto_shutdown_timeout}
    end
  end

  

  @impl true
  def handle_cast({:enqueue, new_state}, _old_state) do
    {:noreply, new_state,new_state.auto_shutdown_timeout}
  end

  def handle_cast({:serve, new_state}, _old_state) do
    {:noreply, new_state,new_state.auto_shutdown_timeout}
  end
  def handle_cast({:reset, new_state}, _old_state) do

    case TakeANumberDeluxe.State.new(new_state.min_number,new_state.max_number,new_state.auto_shutdown_timeout) do
      {:ok,state} ->{:noreply, state,state.auto_shutdown_timeout}
      {:error,reason} -> {:error,reason} 
    end
  end

end
