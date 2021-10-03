defmodule AwsBootstrapTest do
  use ExUnit.Case
  doctest AwsBootstrap

  test "greets the world" do
    assert AwsBootstrap.hello() == :world
  end
end
