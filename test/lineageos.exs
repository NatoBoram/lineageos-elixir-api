defmodule LineageOSTest do
  use ExUnit.Case
  doctest LineageOS

  test "greets the world" do
    assert LineageOS.hello() == :world
  end
end
