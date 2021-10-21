defmodule LineageOS.CLI do
  @moduledoc """
  `lineageos` is a CLI for downloading LineageOS builds.
  
  Usage:
  
  ```sh
  lineageos <device>
  ```
  """

  @spec main(list(String.t())) :: none
  def main(args \\ []) do
    {parsed, args, invalid} = OptionParser.parse(args, switches: [:string])

    cond do
      Enum.count(invalid) > 0 ->
        IO.inspect({parsed, args, invalid})
        help()
        exit(1)

      Enum.count(args) != 1 ->
        help()

      true ->
        args |> hd() |> LineageOS.API.getLatestBuild() |> LineageOS.API.download()
    end
  end

  @spec help() :: :ok
  defp help do
    Enum.join(
      [
        "#{IO.ANSI.bright()}lineageos#{IO.ANSI.normal()} is a CLI for downloading LineageOS builds.",
        "",
        "Usage:",
        "",
        "    lineageos <device>",
        ""
      ],
      "\n"
    )
    |> IO.puts()
  end
end
