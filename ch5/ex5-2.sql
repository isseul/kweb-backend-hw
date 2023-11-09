#1
select `users`.`id`, `users`.`name`, `tickets`.`seat_number` from `users`
inner join `tickets` on `users`.`id`=`tickets`.`user`
where `tickets`.`train` = 11 order by `tickets`.`seat_number`;

#2
select `users`.`id`, `users`.`name`, Count(*) as `trains_count`, Sum(`trains`.`distance`)/10 as `total_distance`
from `tickets`
inner join `trains` on `trains`.`id` = `tickets`.`train`
inner join `users` on `users`.`id` = `tickets`.`user`
group by `users`.`id`
order by `total_distance` desc
limit 0, 6;

#3
select `trains`.`id`, `types`.`name` as `type`, `src`.`name` as `src_stn`, `dst`.`name` as `dst_stn`, Timediff(`arrival`, `departure`) AS `travel_time`
from `trains`
inner join `types` on `types`.`id` = `trains`.`type`
inner join `stations` as `src` on `src`.`id` = `trains`.`source`
inner join `stations` as `dst` on `dst`.`id` = `trains`.`destination`
order by `travel_time` desc
limit 0, 6;

#4
select `types`.`name` as `type`, `src`.`name` as `src_stn`, `dst`.`name` as `dst_stn`,
 `departure`, `arrival`, Round(`types`.`fare_rate` * `trains`.`distance` / 1000, -2) as `fare`
from `trains`
inner join `types` on `types`.`id` = `trains`.`type`
inner join `stations` as `src` on `src`.`id` = `trains`.`source`
inner join `stations` as `dst` on `dst`.`id` = `trains`.`destination`
order by `departure` asc;

#5
select `trains`.`id`, `types`.`name` as `type`, `src`.`name` as `src_stn`, `dst`.`name` as `dst_stn`,
Count(*) as `occuied`, `types`.`max_seats` as `maximum`
from `trains`
inner join `types` on `types`.`id` = `trains`.`type`
inner join `stations` as `src` on `src`.`id` = `trains`.`source`
inner join `stations` as `dst` on `dst`.`id` = `trains`.`destination`
inner join `tickets` on `tickets`.`train` = `trains`.`id`
group by `tickets`.`train`
order by `trains`.`id` asc;

#6
select `trains`.`id`, `types`.`name` as `type`, `src`.`name` as `src_stn`, `dst`.`name` as `dst_stn`,
Count(`tickets`.`id`) as `occuied`, `types`.`max_seats` as `maximum`
from `trains`
left outer join `tickets` on `tickets`.`train` = `trains`.`id`
inner join `types` on `types`.`id` = `trains`.`type`
inner join `stations` as `src` on `src`.`id` = `trains`.`source`
inner join `stations` as `dst` on `dst`.`id` = `trains`.`destination`
group by `tickets`.`train`
order by `trains`.`id` asc;
