defmodule LineageOS.Build do
  @moduledoc """
  A single build file for a LineageOS device.
  """

  defstruct date: Date.utc_today(),
            datetime: DateTime.utc_now(),
            filename: "",
            filepath: "",
            recovery: %LineageOS.Recovery{},
            sha1: "",
            sha256: "",
            size: 0,
            type: "",
            version: ""

  @doc """
  `new` creates a `%LineageOS.Build` from a map.
  """
  @spec new(map) :: %LineageOS.Build{
          date: Date.t(),
          datetime: DateTime.t(),
          filename: String.t(),
          filepath: String.t(),
          recovery: LineageOS.Recovery.t(),
          sha1: String.t(),
          sha256: String.t(),
          size: 0,
          type: String.t(),
          version: String.t()
        }
  def new(map) do
    [year, month, day] =
      map["date"] |> String.split("-", parts: 3, trim: true) |> Enum.map(&String.to_integer/1)

    %LineageOS.Build{
      date:
        Date.new!(
          year,
          month,
          day,
          Calendar.ISO
        ),
      datetime: map["datetime"] |> DateTime.from_unix!(),
      filename: map["filename"],
      filepath: map["filepath"],
      recovery: map["recovery"] |> LineageOS.Recovery.new(),
      sha1: map["sha1"],
      sha256: map["sha256"],
      size: map["size"],
      type: map["type"],
      version: map["version"]
    }
  end
end
