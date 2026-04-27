defmodule DancingDots.Animation do
  defmacro __using__(_opts) do
    quote do
      @behaviour DancingDots.Animation

      @impl DancingDots.Animation

      def init(opts \\ []), do: {:ok, opts}
      defoverridable init: 1
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
  use DancingDots.Animation

  @impl DancingDots.Animation
  def handle_frame(%DancingDots.Dot{} = dot, frame, _opts \\ []) do
    if rem(frame, 4) == 0 do
      %DancingDots.Dot{dot | opacity: dot.opacity * 0.5}
    else
      dot
    end
  end
end

defmodule DancingDots.Zoom do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def init(opts) do
    velocity = opts[:velocity]

    if is_integer(velocity) do
      {:ok, opts}
    else
      {:error,
       "The :velocity option is required, and its value must be a number. Got: #{inspect(velocity)}"}
    end
  end

  @impl DancingDots.Animation
  def handle_frame(%DancingDots.Dot{} = dot, frame, opts \\ []) do
    %DancingDots.Dot{dot | radius: dot.radius + (frame - 1) * Keyword.fetch!(opts, :velocity)}
  end
end
