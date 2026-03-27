defmodule PaintByNumber do
  @moduledoc """
  This is the border of my knowledge and interest. 

  I dont' come here often and everytime I do, I am reminded 
  of why I don't.
  """
  def palette_bit_size(color_count) do
    color_count
    |> palette_bit_size(1)
  end
  defp palette_bit_size(color_count, bit_size) do
    if 2 ** bit_size >= color_count do
      bit_size
    else
     palette_bit_size(color_count, bit_size + 1)
    end
  end

  def empty_picture(),  do: <<>>

  def test_picture(), do: <<0::2, 1::2, 2::2, 3::2>>

  def prepend_pixel(picture, color_count, pixel_color_index) do
    bit_size = palette_bit_size(color_count)
    <<pixel_color_index::size(bit_size), picture::bitstring>>
  end

  def get_first_pixel(picture, color_count) do
    bit_size = palette_bit_size(color_count)
    case picture do
      <<>> -> nil
      <<first::size(bit_size), _rest::bitstring>> -> first
    end
  end

  def drop_first_pixel(picture, color_count) do
    bit_size = palette_bit_size(color_count)
    case picture do
      <<>> -> <<>>
      <<_first::size(bit_size), rest::bitstring>> -> rest
    end
  end

  def concat_pictures(picture1, picture2) do
    case {picture1, picture2} do
      {<<>>, picture2} -> picture2
      {picture1, <<>>} -> picture1
      {picture1, picture2} -> <<picture1::bitstring, picture2::bitstring>>
    end
  end
end
