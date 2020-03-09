INSERT INTO `Company` (`name`, `description`, `website`, `isStation`, `isSupplier`, `isNozzle`, `logo`) VALUES
    ('Generic', '', 'https://nixon-development.com', '0', '0', '1', NULL),
    ('True Zero', 'FirstElement Fuel, Inc.', 'https://www.truezero.com', '1', '0', '0', NULL),
    ('Iwatani', 'IWATANI CORPORATION', 'http://www.iwatani.com', '1', '0', '0', NULL);

INSERT INTO `Nozzle` (`name`, `description`, `company`, `dataInterface`) VALUES ('Generic', 'Generic Nozzle', 'Generic', '');