defmodule NameBadge do

  # let's see how the system likes the use of pattern matching
  # instead of if statements. Because IRL this is is how I'd do it
  
  def print(nil, name, nil), do: "#{name} - OWNER"
  def print(id, name, nil), do: "[#{id}] - #{name} - OWNER"
  def print(nil, name, department), do: "#{name} - #{String.upcase(department)}"
  def print(id, name, department), do: "[#{id}] - #{name} - #{String.upcase(department)}"
  
end
