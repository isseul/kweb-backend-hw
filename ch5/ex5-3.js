const express = require("express");
const { runQuery } = require("./database");
const app = express();
const port = 3000;

app.get("/fare", async (req, res, next) => {
  try {
    const { uid } = req.query;
    const sql =
      "select `users`.`name`" +
      "Sum(Round(`types`.`fare_rate` * `trains`.`distance` / 1000, -2)) as `fare`" +
      "from `tickets`" +
      "inner join `trains` on `tickets`.`train` = `trains`.`id`" +
      "inner join `users` on `tickets`.`user` = `users`.`id` and `users`.`id` = ?" +
      "inner join `types` on `trains`.`type` = `types`.`id`" +
      "group by `users`.`id`;";
    const { name, fare } = (await runQuery(sql, [uid]))[0];
    return res.send(`Total fare of ${name} is ${fare} KRW.`);
  } catch (err) {
    console.error(err);
    return res.sendStatus(500);
  }
});

app.get("/train/status", async (req, res, next) => {
  try {
    const { tid } = req.query;
    const sql =
      "SELECT Count(*) AS occupied, max_seats AS maximum FROM tickets " +
      "INNER JOIN trains ON trains.id = tickets.train AND trains.id = ? " +
      "INNER JOIN types ON trains.type = types.id";
    const { occupied, maximum } = (await runQuery(sql, [tid]))[0];
    const isSeatsLeft = occupied < maximum;
    return res.send(`Train ${tid} is ${isSeatsLeft ? "not " : ""}sold out`);
  } catch (err) {
    console.error(err);
    return res.sendStatus(500);
  }
});
app.listen(port, () => console.log(`Server listening on port ${port}!`));
