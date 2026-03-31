defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  use Agent

  def start(opts \\ []) do
    Agent.start_link(fn -> %{plots: [], next_id: 1} end, name: __MODULE__)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn state -> state[:plots] end)
  end

  def register(pid, register_to) do
    # get id
    plot_id =
      Agent.get_and_update(
        pid,
        fn state ->
          # get next_id
          next_id = state[:next_id]

          # now return the next id and the updated map
          {next_id, %{state | next_id: next_id + 1}}
        end
      )

    # make the plot
    plot = %Plot{plot_id: plot_id, registered_to: register_to}

    # update the agent
    Agent.update(
      pid,
      fn state ->
        Map.update!(state, :plots, fn plots -> [plot | plots] end)
      end
    )

    # return the plot
    plot
  end

  def release(pid, plot_id) do
    Agent.update(
      pid,
      fn state ->
        plots =
          state.plots
          |> Enum.reject(fn plot -> plot.plot_id == plot_id end)

        Map.put(state, :plots, plots)
      end
    )
  end

  def get_registration(pid, plot_id) do
    plot =
      Agent.get(pid, fn state -> state[:plots] end)
      |> Enum.find(fn plot -> plot.plot_id == plot_id end)

    case plot do
      nil -> {:not_found, "plot is unregistered"}
      plot -> plot
    end
  end
end
