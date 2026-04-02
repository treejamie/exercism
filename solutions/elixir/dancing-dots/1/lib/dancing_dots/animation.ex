defmodule DancingDots.Animation do
  defmacro __using__(_opts) do
    quote do
      @behaviour DancingDots.Animation

      @impl DancingDots.Animation
      def init(opts \\ []), do: {:ok, opts}
      defoverridable DancingDots.Animation
    end
  end

  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(opts :: Keyword.t()) :: {:ok, opts :: Keyword.t()} | {:error, any()}
  @callback handle_frame(dot :: dot, frame :: integer, opts :: Keyword.t()) ::
              dot :: dot
end

defmodule DancingDots.Flicker do
  @behaviour DancingDots.Animation

  @impl DancingDots.Animation
  def init(opts \\ []) do
    {:ok, opts}
  end

  @impl DancingDots.Animation
  def handle_frame(dot, frame, _opts \\ []) do
    if rem(frame, 4) == 0 do
      %DancingDots.Dot{dot | opacity: dot.opacity * 0.5}
    else
      dot
    end
  end
end

defmodule DancingDots.Zoom do
  @behaviour DancingDots.Animation

  @impl DancingDots.Animation
  def init(opts \\ []) do
    case Keyword.fetch(opts, :velocity) do
      {:ok, velocity} when is_integer(velocity) ->
        {:ok, opts}

      {:ok, velocity} when not is_integer(velocity) ->
        {:error,
         "The :velocity option is required, and its value must be a number. Got: #{inspect(velocity)}"}

      :error ->
        {:error, "The :velocity option is required, and its value must be a number. Got: nil"}
    end
  end

  @impl DancingDots.Animation
  def handle_frame(dot, frame, opts \\ []) do
    %DancingDots.Dot{dot | radius: dot.radius + (frame - 1) * Keyword.fetch!(opts, :velocity)}
  end
end
