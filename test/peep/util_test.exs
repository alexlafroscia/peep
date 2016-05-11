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

  test "it can get the path for the Ember app" do
    {:ok, result} = ember_app_path
    assert result == Path.join(System.cwd, "test/ember-dummy-app")
  end

  test "it can get the path to the built Ember app" do
    result = ember_dist_dir
    assert result == Path.join([System.cwd, "test/ember-dummy-app", "dist"])
  end

  test "it can run an Ember command" do
    {:ok, app_path} = ember_app_path
    port = ember_command app_path, ["version"]
    receive do
      {^port, {:data, result}} ->
        # Ignore a warning about "watchman" if it happens
        if String.contains?(result, "watchman") do
          receive do
            {^port, {:data, result}} ->
              assert String.contains?(result, "ember-cli")
          end
        else
          assert String.contains?(result, "ember-cli")
        end
    end
  end
end
