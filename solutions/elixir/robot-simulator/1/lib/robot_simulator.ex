defmodule RobotSimulator do
  @type robot() :: any()
  @type direction() :: :north | :east | :south | :west
  @type position() :: {integer(), integer()}

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """

  defstruct pos: {0, 0}, dir: :north
  @spec create(direction, position) :: robot() | {:error, String.t()}
  @valid_dir MapSet.new([:north, :east, :south, :west])

  def create(direction \\ nil, position \\ nil) do
    cond do
      direction == nil and position == nil ->
        %RobotSimulator{}

      direction == nil ->
        %RobotSimulator{pos: position}

      !MapSet.member?(@valid_dir, direction) and direction != nil ->
        {:error, "invalid direction"}

      position == nil or !is_tuple(position) or (tuple_size(position) != 2 and position != nil) ->
        {:error, "invalid position"}

      position != nil and Tuple.to_list(position) |> Enum.any?(fn s -> !is_integer(s) end) ->
        {:error, "invalid position"}

      true ->
        %RobotSimulator{pos: position, dir: direction}
    end
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @valid_instr MapSet.new(["R", "L", "A"])

  @spec simulate(robot, instructions :: String.t()) :: robot() | {:error, String.t()}
  def simulate(robot, instructions) do
    isntr = instructions |> String.graphemes()

    valid =
      Enum.all?(isntr, fn s -> MapSet.member?(@valid_instr, s) end)

    cond do
      valid -> execute(robot, isntr)
      true -> {:error, "invalid instruction"}
    end
  end

  def execute(robot, []), do: robot

  def execute(robot, [h | t]) do
    cond do
      h == "R" or h == "L" ->
        execute(transition(robot, h), t)

      true ->
        execute(advance(robot), t)
    end
  end

  def transition(robot, i) do
    cond do
      i == "R" and robot.dir == :east ->
        %RobotSimulator{pos: robot.pos, dir: :south}

      i == "R" and robot.dir == :south ->
        %RobotSimulator{pos: robot.pos, dir: :west}

      i == "R" and robot.dir == :west ->
        %RobotSimulator{pos: robot.pos, dir: :north}

      i == "R" and robot.dir == :north ->
        %RobotSimulator{pos: robot.pos, dir: :east}

      i == "L" and robot.dir == :north ->
        %RobotSimulator{pos: robot.pos, dir: :west}

      i == "L" and robot.dir == :west ->
        %RobotSimulator{pos: robot.pos, dir: :south}

      i == "L" and robot.dir == :south ->
        %RobotSimulator{pos: robot.pos, dir: :east}

      i == "L" and robot.dir == :east ->
        %RobotSimulator{pos: robot.pos, dir: :north}

      true ->
        robot
    end
  end

  def advance(robot) do
    cond do
      robot.dir == :east ->
        %RobotSimulator{pos: {elem(robot.pos, 0) + 1, elem(robot.pos, 1)}, dir: robot.dir}

      robot.dir == :north ->
        %RobotSimulator{pos: {elem(robot.pos, 0), elem(robot.pos, 1) + 1}, dir: robot.dir}

      robot.dir == :west ->
        %RobotSimulator{pos: {elem(robot.pos, 0) - 1, elem(robot.pos, 1)}, dir: robot.dir}

      robot.dir == :south ->
        %RobotSimulator{pos: {elem(robot.pos, 0), elem(robot.pos, 1) - 1}, dir: robot.dir}

      true ->
        robot
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot) :: direction()
  def direction(robot) do
    robot.dir
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot) :: position()
  def position(robot) do
    robot.pos
  end
end
