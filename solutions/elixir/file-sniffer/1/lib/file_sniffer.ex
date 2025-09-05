defmodule FileSniffer do
  def type_from_extension(extension) do
    # Please implement the type_from_extension/1 function
    cond do
      extension == "exe" -> "application/octet-stream"
      extension == "bmp" -> "image/bmp"
      extension == "png" -> "image/png"
      extension == "jpg" -> "image/jpg"
      extension == "gif" -> "image/gif"
      true -> nil
    end
  end


def type_from_binary(<<0x42, 0x4D, 0>>), do: nil  # Possibly invalid BMP with zero byte
def type_from_binary(<<0x42, 0x4D, _rest::binary>>), do: "image/bmp"
def type_from_binary(<<0x47, 0x49, 0x46, _rest::binary>>), do: "image/gif"

# JPEG: starts with 0xFF 0xD8 and ends with 0xFF 0xD9, needs a complete binary
def type_from_binary(<<0xFF, 0xD8, middle::binary>>=file), do:  last_binary(middle)

def last_binary(bin) when byte_size(bin) >= 2 do
  size = byte_size(bin)
  <<_::binary-size(size - 2), last1, last2>> = bin
  cond do
    last1 == 0xFF and last2 == 0xD9 -> "image/jpg"
    true -> nil 
  end
end
def last_binary(_), do: nil



def type_from_binary(<<0x7F, 0x45, 0x4C, 0x46, _rest::binary>>), do: "application/octet-stream"  # ELF
def type_from_binary(<<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _rest::binary>>), do: "image/png"

def type_from_binary(_), do: nil


  def verify(file_binary, extension) do
    # Please implement the verify/2 function
    fb=type_from_binary(file_binary)
    fe=type_from_extension(extension)
    cond do
       fb == nil or fe ==nil -> {:error, "Warning, file format and file extension do not match."}
       fb==fe  -> {:ok,fb} 
      true -> {:error, "Warning, file format and file extension do not match."}
    end
  end
end
