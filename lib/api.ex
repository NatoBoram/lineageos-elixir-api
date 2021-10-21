defmodule LineageOS.API do
  @moduledoc """
  `API` is an interface to the LineageOS API.
  """

  require HTTPoison
  require Poison

  @type builds :: [LineageOS.Build.t()]
  @type devices :: %{String.t() => builds}

  @api URI.parse("https://mirrorbits.lineageos.org")
  @api_builds URI.parse("#{@api}/api/v1/builds/")

  @doc """
  `getDevices` returns a list of devices that are supported by the LineageOS team.
  """
  @spec getDevices :: devices
  def getDevices do
    response = HTTPoison.get!("#{@api_builds}", [], follow_redirect: true)

    if response.status_code != 200 do
      IO.inspect(response)
      raise "Failed to get devices: #{response.status_code}"
    end

    decoded = Poison.decode!(response.body)
    IO.puts("Received #{IO.ANSI.bright()}#{Enum.count(decoded)}#{IO.ANSI.normal()} devices...")

    Map.new(
      Enum.map(decoded, fn {device, builds} ->
        {device, Enum.map(builds, fn build -> LineageOS.Build.new(build) end)}
      end)
    )
  end

  @doc """
  `getBuilds` returns a list of builds for a given device.
  """
  @spec getBuilds(String.t()) :: builds
  def getBuilds(device), do: getDevices()[device]

  @doc """
  `download` downloads the given build.
  """
  @spec download(Build.t()) :: :ok | {:error, File.posix()} | {:error, HTTPoison.Response.t()}
  def download(build) do
    response = HTTPoison.get!("#{@api}#{build.filepath}", [], follow_redirect: true)

    if response.status_code != 200 do
      IO.inspect(response)
      {:error, response}
    else
      IO.puts("Downloading #{IO.ANSI.green()}#{build.filename}#{IO.ANSI.default_color()}...")
      File.write(build.filename, response.body)
    end
  end

  @doc """
  `getLatestBuild` returns the latest build for a given device.
  """
  @spec getLatestBuild(String.t()) :: Build.t()
  def getLatestBuild(deviceName), do: deviceName |> getBuilds |> List.last()
end
