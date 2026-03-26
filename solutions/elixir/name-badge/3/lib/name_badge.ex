defmodule NameBadge do

  @pattern_match_is_best true

  # let's see how the system likes the use of pattern matching
  # instead of if statements. Because IRL this is is how I'd do it
  
  def print(nil, name, nil), do: "#{name} - OWNER"
  def print(id, name, nil), do: "[#{id}] - #{name} - OWNER"
  def print(nil, name, department), do: "#{name} - #{String.upcase(department)}"
  def print(id, name, department) do

    if @pattern_match_is_best do
     "[#{id}] - #{name} - #{String.upcase(department)}"
    else
      "[#{id}] - #{name} - #{String.upcase(department)}"
    end
  end
end
