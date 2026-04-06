defmodule TakeANumberDeluxe do
  # Client API
  use GenServer

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(init_arg) do
    case TakeANumberDeluxe.State.new(
           init_arg[:min_number],
           init_arg[:max_number],
           init_arg[:auto_shutdown_timeout] || :infinity
         ) do
      {:ok, state} ->
        GenServer.start_link(__MODULE__, state)

      {:error, error} ->
        {:error, error}
    end
  end

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(pid), do: GenServer.call(pid, :report_state)

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(pid), do: GenServer.call(pid, :queue_new_number)

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(pid, priority_number \\ nil),
    do: GenServer.call(pid, {:serve_next_queued_number, priority_number})

  @spec reset_state(pid()) :: :ok
  def reset_state(pid), do: GenServer.call(pid, :reset_state)

  # Server callbacks
  @impl GenServer
  def init(state) do
    {:ok, state, state.auto_shutdown_timeout}
  end

  @impl GenServer
  def handle_info(:timeout, state) do
    {:stop, :normal, state}
  end

  @impl GenServer
  def handle_info(_, state), do: {:noreply, state, state.auto_shutdown_timeout}

  @impl GenServer
  def handle_call(:report_state, _from, state) do
    {:reply, state, state, state.auto_shutdown_timeout}
  end

  @impl GenServer
  def handle_call(:queue_new_number, _from, state) do
    {
      {:error, :all_possible_numbers_are_in_use},
      %TakeANumberDeluxe.State{
        min_number: 1,
        max_number: 2,
        queue: %TakeANumberDeluxe.Queue{in: [2, 1], out: []},
        auto_shutdown_timeout: :infinity
      },
      :infinity
    }

    {reply, new_state} =
      case TakeANumberDeluxe.State.queue_new_number(state) do
        {:ok, next_number, new_state} ->
          {{:ok, next_number}, new_state}

        {:error, error} ->
          {{:error, error}, state}
      end

    {:reply, reply, new_state, state.auto_shutdown_timeout}
  end

  @impl GenServer
  def handle_call({:serve_next_queued_number, priority_number}, _from, state) do
    {reply, state} =
      case TakeANumberDeluxe.State.serve_next_queued_number(state, priority_number) do
        {:ok, number, state} -> {{:ok, number}, state}
        {:error, error} -> {{:error, error}, state}
      end

    {:reply, reply, state, state.auto_shutdown_timeout}
  end

  @impl GenServer
  def handle_call(:reset_state, _from, state) do
    {reply, new_state} =
      case TakeANumberDeluxe.State.new(
             state.min_number,
             state.max_number,
             state.auto_shutdown_timeout
           ) do
        {:ok, new_state} -> {:ok, new_state}
        {:error, error} -> {{:error, error}, state}
      end

    {:reply, reply, new_state, state.auto_shutdown_timeout}
  end

  @impl GenServer
  def handle_call(_, _from, state), do: {:reply, {:error, :invalid_call}, state}
end
