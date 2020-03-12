-- POINT(longitude latitude)
UPDATE `Station` SET `location`=ST_GeomFromText('POINT(0 0),4326') WHERE name = 'FooStation' 