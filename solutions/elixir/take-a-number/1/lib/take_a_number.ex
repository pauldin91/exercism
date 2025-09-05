defmodule TakeANumber do
  def start() do
    spawn(fn -> recv(0) end)
  end

  
  def recv(state) do
    # Please implement the start/0 function
    receive do
      {:report_state, sender_pid} -> 
            send(sender_pid, state)
            recv(state)
      {:take_a_number, sender_pid} -> 
            send(sender_pid,state+1)
            recv(state+1)
      :stop -> nil
      _ -> recv(state)
    end
  end
end
