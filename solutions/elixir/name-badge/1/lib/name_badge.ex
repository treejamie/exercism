defmodule NameBadge do
  def print(id, name, department) do

  # the id
  id = 
    if is_nil(id) do
      ""
    else
      "#{id}"
    end

  # make the parts
  department = 
    if is_nil(department) do
      "OWNER"
    else
      String.upcase(department)
    end

  # and now build it
    if id == "" do
      "#{name} - #{department}"
    else 
      "[#{id}] - #{name} - #{department}"
    end 
  end
  
end
