defmodule Issues.TableFormatter do
  def print_table_for_columns(body, headers) do
    column_widths = determine_widths(body, headers)
    print_header(headers, column_widths)
    print_body(body, headers, column_widths)
  end

  defp determine_widths(body, headers) do
    for x <- headers do
      Enum.max(for y <- body, do: String.length(to_string(y[x])))
    end
  end

  defp print_header(headers, column_widths) do
    combine_params = Enum.zip(headers, column_widths)
    for {x, y} <- combine_params do
      IO.write(String.pad_trailing(x, y) <> "|")
    end
    IO.write("\n-")
    for x<- column_widths do
      IO.write(String.duplicate("-", x)<>"+")
    end
    IO.write("\n")
  end

  defp print_body([head|tail], headers, column_widths) do
    combine_params = Enum.zip(headers, column_widths)
    IO.write(" ")
    for {x, y} <- combine_params do
      IO.write(String.pad_trailing(to_string(head[x]), y) <> "|")
    end
    IO.write("\n")
    print_body(tail, headers, column_widths)
  end  

  defp print_body([], _headers, _column_widths) do
    IO.write("\n")
  end

end
