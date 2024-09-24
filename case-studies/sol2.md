## Problem

Your task is to prepare a list of cities with the date of last reservation made in the city and a main photo (photos[0]) of the most popular (by number of bookings) hotel in this city.

Sort results in ascending order by city. If many hotels have the same amount of bookings sort them by ID (ascending order). Remember that the query will also be run of different datasets.

## Solution

```sql
-- CASE STUDY 2

with city_hotel_bookings as (
select 
    city_id, 
    city.name as city_name, 
    hotel_id, 
    hotel.name as hotel_name, 
    booking.id as booking_id, 
    booking_date,
    photos 
from city, hotel, booking 
where city.id=hotel.city_id 
and hotel.id=booking.hotel_id

), bookings_cte as(
    select city_id, hotel_id, count(booking_id) as bookings, max(count(booking_id)) as max_bookings
    from city_hotel_bookings
    group by hotel_id, city_id
)

select city_id, hotel_id, max(bookings) as maxbookings from 
    bookings_cte
)
group by city_id
having maxbookings = bookings_cte.bookings;

-- select city_id, hotel_id, photos[0] where ct.bookings = max(ct.bookings)



-- select ct.city_id, hotel_id from (
    select city_id, hotel_id, count(booking_id) as bookings, max(count(booking_id)) as max_bookings
    from city_hotel_bookings
    group by hotel_id, city_id
-- ) ct, ct
-- where max_bookings = bookings
-- group by ct.city_id;

(
    select city_name, max(hotel_booking) as last_booking_date from (
        select city_name, hotel_id, max(booking_date) as hotel_booking from city_hotel_bookings
        group by hotel_id, city_name
    )
    group by city_name
    order by city_name;
)
```

![image](https://github.com/user-attachments/assets/ad5984df-2797-47f5-92d0-4ec5110d1d93)
