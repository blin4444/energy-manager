-- Test polyfill for ST_Distance_Sphere
SET @pt1 = ST_GeomFromText('POINT(0 0)');
SET @pt2 = ST_GeomFromText('POINT(180 0)');
SELECT ST_Distance_Sphere_pf(@pt1, @pt2);

-- https://dev.mysql.com/doc/refman/5.7/en/spatial-convenience-functions.html
-- Expected value: 20015042.813723423
