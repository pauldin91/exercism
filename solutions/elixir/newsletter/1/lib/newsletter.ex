defmodule Newsletter do
  def read_emails(path) do
    # Please implement the read_emails/1 function
    {:ok, f} = File.open(path, [:read])
    line_by_line(f)
  end

  def line_by_line(:eof, lines), do: lines

  def line_by_line(file, lines \\ []) do
    case IO.read(file, :line) do
      :eof -> Enum.reverse(lines)
      line -> line_by_line(file, [String.trim(line,"\n") | lines])
    end
  end

  def open_log(path) do
    # Please implement the open_log/1 function
    {:ok,f} = File.open(path,[:write])
    f
  end

  def log_sent_email(pid, email) do
    # Please implement the log_sent_email/2 function
    IO.write(pid,email <> "\n")
  end

  def close_log(pid) do
    # Please implement the close_log/1 function
    File.close(pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    # Please implement the send_newsletter/3 function
    emails = read_emails(emails_path)
    log = open_log(log_path)
    handle(emails,log,send_fun)
  end

  def handle([], pid, send_fun), do: :ok
  def handle([he|te], pid, send_fun) do
  
    case send_fun.(he) do
      :ok ->
        log_sent_email(pid, he)
          _error ->
      :noop
    end
        handle(te, pid, send_fun)
  end
  
end
