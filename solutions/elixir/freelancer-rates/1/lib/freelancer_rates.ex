defmodule FreelancerRates do
  def daily_rate(hourly_rate) do
    # Please implement the daily_rate/1 function
    8.0*hourly_rate
  end

  def apply_discount(before_discount, discount) do
    # Please implement the apply_discount/2 function
    before_discount-discount*before_discount/100
  end

  def monthly_rate(hourly_rate, discount) do
    # Please implement the monthly_rate/2 function
    total =22*daily_rate(hourly_rate)
    ceil(total-(discount*total/100))
  end

  def days_in_budget(budget, hourly_rate, discount) do
    # Please implement the days_in_budget/3 function
    day_cost = Float.floor(daily_rate(hourly_rate),1)
    day_cost = day_cost - Float.floor(discount*day_cost/100.0,1)
    Float.floor(budget/day_cost,1)
  end
end
