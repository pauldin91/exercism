defmodule LibraryFees do
  def datetime_from_string(string) do
    # Please implement the datetime_from_string/1 function
     {_,parsed} = NaiveDateTime.from_iso8601(string)
     parsed
  end

  def before_noon?(datetime) do
    # Please implement the before_noon?/1 function
    datetime.hour<12
  end

  def return_date(checkout_datetime) do
    # Please implement the return_date/1 function
    cond do 
      checkout_datetime.hour<12 -> NaiveDateTime.to_date(NaiveDateTime.add(checkout_datetime,28,:day))
      true -> NaiveDateTime.to_date(NaiveDateTime.add(checkout_datetime,29,:day))
    end
  end

  def days_late(planned_return_date, actual_return_datetime) do
    # Please implement the days_late/2 function
    ret_date = NaiveDateTime.to_date(actual_return_datetime)
    late = Date.diff(ret_date,planned_return_date)
    cond do 
      late>0->late
      true->0
    end
  end

  def monday?(datetime) do
    # Please implement the monday?/1 function
    s = NaiveDateTime.to_date(datetime)
    {m,_,_}=Calendar.ISO.day_of_week(s.year,s.month,s.day,:monday)
    m==1
  end

  def calculate_late_fee(checkout, return, rate) do
    # Please implement the calculate_late_fee/3 function
    dt1 = return_date(datetime_from_string(checkout))
    dt2 = datetime_from_string(return)
    cond do 
      monday?(dt2) -> days_late(dt1,dt2) * rate * 0.5 |> floor()
      true -> days_late(dt1,dt2) * rate 
    end
  end
end
