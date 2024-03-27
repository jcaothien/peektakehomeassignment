with raw as (
select 
transaction_date,
--cancellations
round(total_bookings*cancelation_rate,0) as total_cancelations,
abs(total_canceled_ahead_days) as total_canceled_ahead_days,
round(abs(total_canceled_ahead_days)/(total_bookings*cancelation_rate),1) as avg_canceled_ahead_days,
--bookings
total_bookings,
abs(total_booked_ahead_days) as total_booked_ahead_days,
round(abs(total_booked_ahead_days)/total_bookings,1) as avg_booked_ahead_days,
--
cancelation_rate,
seven_day_rolling_avg

from peektakehome.takehome

order by 1 
)

, month_year as (
##this query groups the data by month-year to look at monthly and yearly trends
select 
format_date("%Y-%m %B",transaction_date) as year_month,
--cancellations
sum(round(total_bookings*cancelation_rate,0)) as monthly_total_cancelations,
sum(abs(total_canceled_ahead_days)) as monthly_total_canceled_ahead_days,
round(sum(abs(total_canceled_ahead_days))/sum((total_bookings*cancelation_rate)),1) as monthly_avg_canceled_ahead_days,
--bookings
sum(total_bookings) as monthly_total_bookings,
sum(abs(total_booked_ahead_days)) as monthly_total_booked_ahead_days,
round(sum(abs(total_booked_ahead_days))/sum(total_bookings),1) as monthly_avg_booked_ahead_days,
--
avg(cancelation_rate) as monthly_avg_concelation_rate,
avg(seven_day_rolling_avg) as monthly_avg_seven_day_rolling_avg

from peektakehome.takehome
group by 1
order by 1 
)