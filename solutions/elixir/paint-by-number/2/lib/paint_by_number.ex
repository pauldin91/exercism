defmodule PaintByNumber do
  import Bitwise

  def palette_bit_size(color_count) do
    lo = log(color_count, 0)
    cond do 
      color_count <= 2 <<< (lo - 1) -> lo
      true-> lo + 1
    end
  end

  defp log(ex, t) when ex >= 0 do
    cond do 
      ex ==1 -> t
      true -> log(div(ex, 2), t + 1)
    end
  end

  def empty_picture(), do: <<>>

  def test_picture(), do: <<0::2, 1::2, 2::2, 3::2>>

  def prepend_pixel(picture, color_count, pixel_color_index) do
    bit_size = palette_bit_size(color_count)
    <<pixel_color_index::size(bit_size), picture::bitstring>>
  end

def get_first_pixel(<<>>, _bit_size), do: nil
def get_first_pixel(picture, color_count) do
   bit_size = palette_bit_size(color_count)
  <<pixel::size(bit_size), _rest::bitstring>> = picture
  pixel
end

def drop_first_pixel(<<>>, _bit_size), do: <<>>
def drop_first_pixel(picture, color_count) do
   bit_size = palette_bit_size(color_count)
  <<_pixel::size(bit_size), rest::bitstring>> = picture
  rest
end

def concat_pictures(p1, p2), do: <<p1::bitstring, p2::bitstring>>

end
