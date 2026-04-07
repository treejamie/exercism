defmodule Newsletter do
  def read_emails(path) do
    File.read!(path)
    |> String.split("\n")
    |> Enum.filter(&(&1 != ""))
  end

  def open_log(path) do
    File.open!(path, [:write])
  end

  def log_sent_email(pid, email), do: IO.puts(pid, email)

  def close_log(pid), do: File.close(pid)

  def send_newsletter(emails_path, log_path, send_fun) do
    pid = open_log(log_path)

    Enum.each(read_emails(emails_path), fn email ->
      case send_fun.(email) do
        :ok -> log_sent_email(pid, email)
        _ -> :error
      end
    end)

    close_log(pid)
  end
end
