defmodule LogLevel do
  def to_label(log_code, legacy?) do
    cond do
      {log_code, legacy?} == {0, true} -> :unknown
      {log_code, legacy?} == {5, true} -> :unknown
      log_code == 0 -> :trace
      log_code == 1 -> :debug
      log_code == 2 -> :info
      log_code == 3 -> :warning
      log_code == 4 -> :error
      log_code == 5 -> :fatal
      true -> :unknown
    end
  end


  def alert_recipient(level, legacy?) do
    label = to_label(level, legacy?)
    cond do
      {label, legacy?} == {:unknown, true} -> :dev1
      label == :unknown -> :dev2
      label in [:error, :fatal] -> :ops
      true -> false
    end
  end
end
