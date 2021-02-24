defmodule Rocketpay.Numbers do
  def sum_from_file(filename) do
    "#{filename}.csv" |> File.read() |> handle_file()
  end

  defp handle_file({:ok, result}) do
    {:ok, %{result:
      result |> String.split(",") |> Enum.map(fn number -> String.to_integer(number) end) |> Enum.sum()
    }}
  end

  defp handle_file({:error, _reason}), do: {:error, %{message: "Invalid file!"}}

end
