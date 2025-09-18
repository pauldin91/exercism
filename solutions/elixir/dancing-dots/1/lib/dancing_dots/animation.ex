defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(opts :: any) :: any
  @callback handle_frame(dot :: dot, frame_number :: pos_integer, opts :: opts) :: any
  # Please implement the module
  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation
      def init(opts), do: {:ok,opts}
      defoverridable init: 1
    end
  end

end

defmodule DancingDots.Flicker do
  @behaviour DancingDots.Animation
  # Please implement the module
  use DancingDots.Animation
  
  @impl DancingDots.Animation
  def handle_frame(dot,frame_number,opts) do
  cond do
  rem(frame_number,4)==0->
     %DancingDots.Dot{opacity: dot.opacity * 0.5, radius: dot.radius, x: dot.x, y: dot.y}
  true->
     %DancingDots.Dot{opacity: dot.opacity, radius: dot.radius, x: dot.x, y: dot.y}
     end
  
  end
end

defmodule DancingDots.Zoom do
@behaviour DancingDots.Animation
  # Please implement the module
    @impl DancingDots.Animation
  def init(opts) do
  velocity = Keyword.get(opts,:velocity)
    cond do
       velocity !=nil and is_integer(velocity) -> {:ok,opts}
       velocity !=nil -> {:error, "The :velocity option is required, and its value must be a number. Got: \"#{velocity}\""}
       true -> {:error, "The :velocity option is required, and its value must be a number. Got: nil"}
    end
  end
  @impl DancingDots.Animation
  def handle_frame(dot,frame_number,opts) do
      velocity = Keyword.get(opts,:velocity,1)
     %DancingDots.Dot{opacity: dot.opacity, radius: dot.radius+(frame_number-1)*velocity, x: dot.x, y: dot.y}
  end
end
