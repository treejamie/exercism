defmodule HighSchoolSweetheart do

  def first_letter(name) do
    name
    |> String.trim()
    |> String.first()
  end

  def initial(name) do
    name
    |> first_letter()
    |> String.upcase()
    |> String.pad_trailing(2, ".")
  end

  def initials(full_name) do
    full_name
    |> String.split()
    |> Enum.map(&initial/1)
    |> Enum.join(" ")
  end

  def pair(full_name1, full_name2) do
    # split them up
    [i1, i2] = 
      [full_name1, full_name2]
      |> Enum.map(&initials/1)

    # do the thing - this was my first pass
    #[
    #  "❤-------------------❤\n",
    #  "|  ", i1, "  +  ", i2,  "  |\n",
    #  "❤-------------------❤\n"
    #]
    #|> Enum.join()
    
    
    # and second pass. The system suggested the below heredoc style.
    # Yes, it is much nicer.
    """
    ❤-------------------❤
    |  #{i1}  +  #{i2}  |
    ❤-------------------❤
    """
  end
end
