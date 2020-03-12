-- ST_Distance_Sphere polyfill for MariaDB
DROP FUNCTION IF EXISTS `ST_Distance_Sphere_pf`;
DELIMITER //
CREATE FUNCTION `ST_Distance_Sphere_pf`(`pt1` POINT, `pt2` POINT) RETURNS decimal(10,2)
BEGIN
    DECLARE degToRad DOUBLE;
    DECLARE earthRadiusMean MEDIUMINT;
    DECLARE diffY DOUBLE;
    DECLARE diffX DOUBLE;
    SET degToRad = pi() / 180;
    SET earthRadiusMean = 6370986;
    SET diffY = ST_Y(pt2) - ST_Y(pt1);
    SET diffX = ST_X(pt2) - ST_X(pt1);
    return 2 * earthRadiusMean * ASIN(
        SQRT(
            POWER(SIN(diffY * degToRad / 2), 2) +
            COS(ST_Y(pt1) * degToRad) * COS(ST_Y(pt2) * degToRad) *
            POWER(SIN(diffX * degToRad / 2), 2)
        )
    );
END//
DELIMITER ;

-- Find nearest stations
-- Usage example: CALL findNearestStations(-122.0621447, 37.5418149)
DROP PROCEDURE IF EXISTS findNearestStations;
DELIMITER //
CREATE PROCEDURE findNearestStations (IN lng FLOAT, IN lat FLOAT)
BEGIN
    SELECT `name`, `address`, `city`, ST_Distance_Sphere_pf(`location`, ST_GeomFromText(CONCAT('POINT (', lng, ' ', lat, '),4326'))) AS `distance`
    FROM `Station`
    ORDER BY `distance`
    LIMIT 5;
END//
DELIMITER ;
