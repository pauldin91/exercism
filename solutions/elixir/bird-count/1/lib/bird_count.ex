defmodule BirdCount do
  def today([head|_tail]) do
    # Please implement the today/1 function
    head
  end
  def today([]) do
    # Please implement the today/1 function
    nil
  end

  def increment_day_count([h|t]) do
    # Please implement the increment_day_count/1 function
    [h+1|t]
  end

  def increment_day_count([]) do
    # Please implement the increment_day_count/1 function
    [1]
  end

  def has_day_without_birds?([h|t]) do
    # Please implement the has_day_without_birds?/1 function
    cond do
    h==0 -> true
    true -> has_day_without_birds?(t)
  end
  end

  def has_day_without_birds?([]) do
    # Please implement the has_day_without_birds?/1 function
    false
  end

  def total([h|t]) do
    # Please implement the total/1 function
    cond do
      
      t!=[] -> h + total(t)  
      true -> 0
    end
  end
  
  def total([]) do
    # Please implement the total/1 function
    0
  end

  def busy_days([h | t]) do
    # Please implement the total/1 function
    cond do
      h >= 5 -> 1 + busy_days(t)
      h < 5 -> busy_days(t)
    end
  end

  def busy_days([]) do
    # Please implement the total/1 function
    0
  end
end
