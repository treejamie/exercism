defmodule LogLevel do
  def to_label(log_code, legacy?)
  def to_label(0, true),  do: :unknown
  def to_label(0, _),  do: :trace
  def to_label(1, _),  do: :debug
  def to_label(2, _),  do: :info
  def to_label(3, _),  do: :warning
  def to_label(4, _),  do: :error
  def to_label(5, true),  do: :unknown
  def to_label(5, _),  do: :fatal
  def to_label(_, _),  do: :unknown


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
