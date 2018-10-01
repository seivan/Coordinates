defmodule DuniaTest do
  use ExUnit.Case
  doctest Dunia

  test "greets the world" do
    assert Dunia.hello() == :world
  end
end
