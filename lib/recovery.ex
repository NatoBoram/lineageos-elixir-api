defmodule LineageOS.Recovery do
  @moduledoc """
  A recovery file for a LineageOS device.
  """
  defstruct filename: "",
            filepath: "",
            sha1: "",
            sha256: "",
            size: 0

  @doc """
  `new` creates a `%LineageOS.Recovery` from a map.
  """
  @spec new(map) :: %LineageOS.Recovery{
          filename: String.t(),
          filepath: String.t(),
          sha1: String.t(),
          sha256: String.t(),
          size: integer()
        }
  def new(map) do
    %LineageOS.Recovery{
      filename: map["filename"],
      filepath: map["filepath"],
      sha1: map["sha1"],
      sha256: map["sha256"],
      size: map["size"]
    }
  end
end
