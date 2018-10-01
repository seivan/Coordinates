defmodule Dunia do
  @moduledoc """
  Documentation for Dunia.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Dunia.hello
      :world

  """
  def hello do
    x = Point.new(1, 2)

    :world
  end
end

alias Dunia.Utils.TypedStruct




defmodule Point do
  use TypedStruct, x: number, y: number

  @spec new(%{x: number, y: number}) :: t
  def new(%{x: x, y: y}), do: __MODULE__.new(x, y)


  @spec new(x: number, y: number) :: t
  def new(x: x, y: y), do: __MODULE__.new(x, y)


  @spec new(number, number) :: t
  def new(x, y), do: %__MODULE__{x: x, y: y}


  @spec zero :: t
  def zero(), do: __MODULE__.new(0, 0)

end

defmodule Size do
  use TypedStruct, width: number, height: number

  @spec new(%{width: number, height: number}) :: t
  def new(%{width: x, height: y}), do: __MODULE__.new(x, y)


  @spec new(width: number, height: number) :: t
  def new(width: x, height: y), do:  __MODULE__.new(x, y)


  @spec new(number, number) :: t
  def new(x, y), do: %__MODULE__{width: x, height: y}


  @spec zero :: t
  def zero(), do: __MODULE__.new(0, 0)

end


defmodule Rect do

  use TypedStruct, origin: Point.t(), size: Size.t()

  @spec new(%{x: number, y: number, width: number, height: number}) :: t
  def new(%{x: x, y: y, width: width, height: height}), do: __MODULE__.new(x, y, width, height)


  @spec new(x: number, y: number, width: number, height: number) :: t
  def new(x: x, y: y, width: width, height: height), do: __MODULE__.new(x, y, width, height)


  @spec new(number, number, number, number) :: t
  def new(x, y, width, height), do: __MODULE__.new(%Point{x: x, y: y}, %Size{width: width, height: height})


  @spec new(Point.t(), Size.t()) :: t
  def new(point, size), do: %__MODULE__{origin: point, size: size}


  @spec zero :: t
  def zero(), do: __MODULE__.new(0, 0, 0, 0)


  @spec min(t, :x | :y) :: number
  def min(rect, :x), do: rect.origin.x
  def min(rect, :y), do: rect.origin.y

  @spec mid(t, :x | :y) :: number
  def mid(rect, :x), do: rect.origin.x + rect.size.width / 2
  def mid(rect, :y), do: rect.origin.y + rect.size.height / 2

  @spec max(t, :x | :y) :: number
  def max(rect, :x), do: rect.origin.x + rect.size.width
  def max(rect, :y), do: rect.origin.y + rect.size.height

  @spec width(t) :: number
  def width(rect), do: rect.size.width

  @spec height(t) :: number
  def height(rect), do: rect.size.height

  @spec center(t) :: Point.t()
  def center(rect), do: %Point{x: rect |> __MODULE__.mid(:x), y: rect |> __MODULE__.mid(:y)}

  @spec contains(t, Point.t()) :: boolean
  def contains(rect, %Point{x: x, y: y}) do
    m = __MODULE__
    rect |> m.min(:x) <= x &&
    rect |> m.max(:x) > x &&
    rect |> m.min(:y) <= y &&
    rect |> m.max(:y) > y
  end

  @spec contains(t, t) :: boolean
  def contains(rect, otherRect) do
    m = __MODULE__
    rect |> m.min(:x) <= otherRect |> m.min(:x) &&
    rect |> m.max(:x) >= otherRect |> m.max(:x) &&
    rect |> m.min(:y) <= otherRect |> m.min(:y) &&
    rect |> m.max(:y) >= otherRect |> m.max(:y)
  end
end
