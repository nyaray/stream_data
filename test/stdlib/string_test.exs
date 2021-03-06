defmodule StreamData.StringTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  @moduletag :stdlib

  # From https://github.com/elixir-lang/elixir/pull/6559
  property "String.replace* functions replace the whole string" do
    check all string <- string(:printable),
              replacement <- string(:printable) do
      assert String.replace(string, string, replacement) == replacement
      assert String.replace_prefix(string, string, replacement) == replacement
      assert String.replace_suffix(string, string, replacement) == replacement
    end
  end

  if Version.match?(System.version(), "~> 1.6") do
    # From https://github.com/elixir-lang/elixir/issues/7023.
    property "String.replace/3 is equivalent to String.split/1 + Enum.join/2" do
      check all string <- string(:printable),
                pattern <- string(:printable),
                replacement <- string(:printable) do
        assert String.replace(string, pattern, replacement) ==
                 string |> String.split(pattern) |> Enum.join(replacement)
      end
    end
  end
end
