

DROP DATABASE IF EXISTS universe;
CREATE DATABASE universe;
\c universe

-- ---------- TABLES ----------

CREATE TABLE galaxy (
  galaxy_id SERIAL PRIMARY KEY,
  name VARCHAR(50) UNIQUE NOT NULL,
  galaxy_type VARCHAR(30) NOT NULL,
  age_in_millions_of_years INT NOT NULL,
  distance_from_earth_mly NUMERIC(10,3),
  description TEXT,
  is_spiral BOOLEAN,
  has_life BOOLEAN
);

CREATE TABLE star (
  star_id SERIAL PRIMARY KEY,
  name VARCHAR(50) UNIQUE NOT NULL,
  galaxy_id INT NOT NULL REFERENCES galaxy(galaxy_id),
  age_in_millions_of_years INT NOT NULL,
  mass_in_solar_masses NUMERIC(10,3),
  description TEXT,
  is_spherical BOOLEAN,
  has_planets BOOLEAN
);

CREATE TABLE planet (
  planet_id SERIAL PRIMARY KEY,
  name VARCHAR(50) UNIQUE NOT NULL,
  star_id INT NOT NULL REFERENCES star(star_id),
  planet_type VARCHAR(30) NOT NULL,
  age_in_millions_of_years INT,
  distance_from_star_million_km NUMERIC(10,3),
  description TEXT,
  is_spherical BOOLEAN,
  has_life BOOLEAN
);

CREATE TABLE moon (
  moon_id SERIAL PRIMARY KEY,
  name VARCHAR(50) UNIQUE NOT NULL,
  planet_id INT NOT NULL REFERENCES planet(planet_id),
  diameter_km INT NOT NULL,
  discovered_year INT,
  gravity_m_s2 NUMERIC(6,3),
  description TEXT,
  is_spherical BOOLEAN,
  has_atmosphere BOOLEAN
);

CREATE TABLE asteroid (
  asteroid_id SERIAL PRIMARY KEY,
  name VARCHAR(50) UNIQUE NOT NULL,
  star_id INT NOT NULL REFERENCES star(star_id),
  diameter_km NUMERIC(10,2) NOT NULL,
  discovered_year INT,
  description TEXT,
  is_near_earth BOOLEAN,
  is_spherical BOOLEAN
);

-- ---------- DATA ----------

INSERT INTO galaxy (name, galaxy_type, age_in_millions_of_years, distance_from_earth_mly, description, is_spiral, has_life) VALUES
('Milky Way', 'Barred Spiral', 13600, 0, 'Our home galaxy', TRUE, TRUE),
('Andromeda', 'Spiral', 10000, 2.537, 'Nearest large galaxy to the Milky Way', TRUE, FALSE),
('Triangulum', 'Spiral', 10000, 2.723, 'Third largest galaxy in the Local Group', TRUE, FALSE),
('Whirlpool', 'Spiral', 400, 31.000, 'Interacting grand-design spiral galaxy', TRUE, FALSE),
('Sombrero', 'Unbarred Spiral', 13250, 29.350, 'Bright nucleus with a large central bulge', TRUE, FALSE),
('Large Magellanic Cloud', 'Irregular', 13000, 0.163, 'Satellite galaxy of the Milky Way', FALSE, FALSE);

INSERT INTO star (name, galaxy_id, age_in_millions_of_years, mass_in_solar_masses, description, is_spherical, has_planets) VALUES
('Sun', 1, 4600, 1.000, 'The star at the center of our solar system', TRUE, TRUE),
('Proxima Centauri', 1, 4850, 0.122, 'Closest known star to the Sun', TRUE, TRUE),
('Alpha Centauri A', 1, 5300, 1.100, 'Main star of the Alpha Centauri system', TRUE, TRUE),
('Sirius', 1, 242, 2.063, 'Brightest star in the night sky', TRUE, FALSE),
('Betelgeuse', 1, 10, 16.500, 'Red supergiant in Orion', TRUE, FALSE),
('Rigel', 1, 8, 21.000, 'Blue supergiant in Orion', TRUE, FALSE);

INSERT INTO planet (name, star_id, planet_type, age_in_millions_of_years, distance_from_star_million_km, description, is_spherical, has_life) VALUES
('Mercury', 1, 'Terrestrial', 4500, 57.900, 'Smallest planet and closest to the Sun', TRUE, FALSE),
('Venus', 1, 'Terrestrial', 4500, 108.200, 'Hottest planet with a thick atmosphere', TRUE, FALSE),
('Earth', 1, 'Terrestrial', 4540, 149.600, 'Our home planet', TRUE, TRUE),
('Mars', 1, 'Terrestrial', 4500, 227.900, 'The red planet', TRUE, FALSE),
('Jupiter', 1, 'Gas Giant', 4500, 778.500, 'Largest planet in the solar system', TRUE, FALSE),
('Saturn', 1, 'Gas Giant', 4500, 1434.000, 'Known for its prominent rings', TRUE, FALSE),
('Uranus', 1, 'Ice Giant', 4500, 2871.000, 'Rotates on its side', TRUE, FALSE),
('Neptune', 1, 'Ice Giant', 4500, 4495.000, 'Farthest known planet from the Sun', TRUE, FALSE),
('Proxima b', 2, 'Terrestrial', 4850, 7.250, 'Exoplanet in the habitable zone of Proxima Centauri', TRUE, FALSE),
('Proxima c', 2, 'Super-Earth', 4850, 223.000, 'Candidate cold super-Earth', TRUE, FALSE),
('Proxima d', 2, 'Terrestrial', 4850, 4.300, 'Small exoplanet very close to its star', TRUE, FALSE),
('Alpha Centauri A b', 3, 'Gas Giant', 5300, NULL, 'Candidate planet around Alpha Centauri A', TRUE, FALSE);

INSERT INTO moon (name, planet_id, diameter_km, discovered_year, gravity_m_s2, description, is_spherical, has_atmosphere) VALUES
('Moon', 3, 3474, NULL, 1.620, 'Earth''s only natural satellite', TRUE, FALSE),
('Phobos', 4, 22, 1877, 0.006, 'Larger moon of Mars', FALSE, FALSE),
('Deimos', 4, 12, 1877, 0.003, 'Smaller moon of Mars', FALSE, FALSE),
('Io', 5, 3643, 1610, 1.796, 'Most volcanically active body in the solar system', TRUE, FALSE),
('Europa', 5, 3122, 1610, 1.315, 'Icy moon with a subsurface ocean', TRUE, FALSE),
('Ganymede', 5, 5268, 1610, 1.428, 'Largest moon in the solar system', TRUE, FALSE),
('Callisto', 5, 4821, 1610, 1.235, 'Heavily cratered moon of Jupiter', TRUE, FALSE),
('Titan', 6, 5150, 1655, 1.352, 'Largest moon of Saturn with a thick atmosphere', TRUE, TRUE),
('Enceladus', 6, 504, 1789, 0.113, 'Ice geysers erupt from its south pole', TRUE, FALSE),
('Mimas', 6, 396, 1789, 0.064, 'Has a giant impact crater called Herschel', TRUE, FALSE),
('Rhea', 6, 1527, 1672, 0.264, 'Second largest moon of Saturn', TRUE, FALSE),
('Dione', 6, 1123, 1684, 0.232, 'Icy moon of Saturn', TRUE, FALSE),
('Tethys', 6, 1062, 1684, 0.146, 'Icy moon with a huge canyon', TRUE, FALSE),
('Iapetus', 6, 1469, 1671, 0.223, 'Two-toned moon of Saturn', TRUE, FALSE),
('Titania', 7, 1578, 1787, 0.379, 'Largest moon of Uranus', TRUE, FALSE),
('Oberon', 7, 1523, 1787, 0.346, 'Second largest moon of Uranus', TRUE, FALSE),
('Miranda', 7, 472, 1948, 0.079, 'Moon with extreme and varied terrain', TRUE, FALSE),
('Ariel', 7, 1158, 1851, 0.269, 'Bright moon of Uranus', TRUE, FALSE),
('Triton', 8, 2707, 1846, 0.779, 'Largest moon of Neptune with retrograde orbit', TRUE, TRUE),
('Nereid', 8, 340, 1949, 0.070, 'Moon of Neptune with an eccentric orbit', FALSE, FALSE);

INSERT INTO asteroid (name, star_id, diameter_km, discovered_year, description, is_near_earth, is_spherical) VALUES
('Ceres', 1, 939.40, 1801, 'Dwarf planet in the asteroid belt', FALSE, TRUE),
('Vesta', 1, 525.40, 1807, 'Second most massive asteroid', FALSE, TRUE),
('Pallas', 1, 512.00, 1802, 'Third largest asteroid in the belt', FALSE, FALSE),
('Bennu', 1, 0.49, 1999, 'Near-Earth asteroid visited by OSIRIS-REx', TRUE, FALSE);
