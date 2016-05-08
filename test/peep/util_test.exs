defmodule PeepUtilTest do
  use ExUnit.Case, async: true
  doctest Peep

  import Peep.Util

  test "it can get Ember app directory from String name" do
    {:ok, result} = app_directory("test-app")
    assert result == Path.join(System.cwd, "test-app")
  end

  test "it can get Ember app directory from Atom name" do
    {:ok, result} = app_directory(:ui)
    assert result == Path.join(System.cwd, "ui")
  end
end
