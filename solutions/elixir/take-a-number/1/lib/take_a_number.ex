defmodule TakeANumber do
  def start() do
    spawn(__MODULE__, :loop, [0])
  end

  def loop(state) do
    receive do
      {:report_state, sender} -> 
        send(sender, state)
        loop(state)
        
      {:take_a_number, sender} ->
        state = state + 1
        send(sender, state)
        loop(state)

      :stop -> nil

      unexpected -> loop(state)
      
    end
  end


  def foo, do: :foo
end
