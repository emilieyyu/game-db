-- Updating Miles Trigger
CREATE TRIGGER milesUpdate
ON dbo.Booking 
AFTER INSERT, DELETE, UPDATE
AS
BEGIN
	UPDATE passenger set miles = td.newMiles 
	FROM (SELECT p.passenger_id, p.miles + SUM(F.distance) AS newMiles
	FROM passenger p INNER JOIN inserted i
	ON i.passenger_id = p.passenger_id
	INNER JOIN Flight F ON F.flight_code = i.flight_code
	GROUP BY p.passenger_id, p.miles) AS td
	WHERE passenger.passenger_id = td.passenger_id

	UPDATE passenger SET miles = td.newMiles 
	FROM (SELECT p.passenger_id, p.miles - SUM(F.distance) AS newMiles
	FROM passenger p INNER JOIN deleted i
	ON i.passenger_id = p.passenger_id
	INNER JOIN Flight F ON F.flight_code = i.flight_code
	GROUP BY p.passenger_id, p.miles) AS td
	WHERE passenger.passenger_id = td.passenger_id
END

-- Adding and Deleting Booking Triggers
CREATE TRIGGER add_booking
ON Booking
AFTER INSERT, DELETE, UPDATE
AS
BEGIN
  UPDATE Flight_Instance set available_seats = available_seats - @@ROWCOUNT
  FROM inserted, Flight_Instance
  WHERE inserted.flight_code = Flight_Instance.flight_code AND inserted.depart_date = Flight_Instance.depart_date
END

CREATE TRIGGER del_booking
ON Booking
AFTER INSERT, DELETE, UPDATE
AS
BEGIN
  UPDATE Flight_Instance set available_seats = available_seats + @@ROWCOUNT
  FROM deleted, Flight_Instance
  WHERE deleted.flight_code = Flight_Instance.flight_code AND deleted.depart_date = Flight_Instance.depart_date
END
