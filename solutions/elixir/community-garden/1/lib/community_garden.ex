# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    # Please implement the start/1 function
     Agent.start_link(fn -> %{next_id: 1, states: []} end, opts)
  end

  def list_registrations(pid), do: Agent.get(pid, fn %{states: states} -> states end)

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn %{next_id: next_id,states: states} ->
      
      res = %Plot{plot_id: next_id, registered_to: register_to}

      {res, %{next_id: next_id + 1 , states: [res | states]}}
    end)
  end

  def release(pid, plot_id) do
    # Please implement the release/2 function
    Agent.update(pid, fn %{states: states}=state ->
      %{state | states: Enum.reject(states, fn s -> s.plot_id == plot_id end)}
    end)
  end

  def get_registration(pid, plot_id) do
    # Please implement the get_registration/2 function
    Agent.get(pid, fn %{states: states} ->
      res = Enum.find(states, fn s -> s.plot_id == plot_id end)

      cond do
        res == nil -> {:not_found, "plot is unregistered"}
        true -> res
      end
    end)
  end
end
