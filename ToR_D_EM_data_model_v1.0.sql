# WGTIFD ToR D Data Model
# Brant McAfee and Helen Holah
# Last Update: 13-08-2024 by Lauren Clayton 
# Last Update: Updating fields, data types, length/precision
#-----------------------------------------------------------#

CREATE TABLE IF NOT EXISTS trip (
    vessel_identifier CHAR(16),
    partner_vessel_identifier CHAR(16),
    operator_identifier CHAR(30),
    partner_operator_identifier CHAR(30),
    vessel_flag_country CHAR(3),
    partner_vessel_flag_country CHAR(3),
    trip_code VARCHAR(20) PRIMARY KEY,
    logbook_identifier VARCHAR(20),
    trip_type CHAR(30),
    project CHAR(30),
    trip_start_timestamp TIMESTAMPTZ,
    trip_end_timestamp TIMESTAMPTZ,
    trip_start_harbour VARCHAR(5),
    trip_end_harbour VARCHAR(5),
    days_at_sea INT,
    vendor_id CHAR(20),
    complete_review CHAR(5),
    date_reviewed DATE,
    date_submitted DATE,
    record_type CHAR(2));

CREATE TABLE IF NOT EXISTS haul (
    trip_code VARCHAR(20),
    station_number INT,
    fishing_validity VARCHAR(5),
    reviewed VARCHAR(5),
    gear_type VARCHAR(20),
    mesh_size INT,
    selection_device VARCHAR(20),
    haul_start TIMESTAMPTZ,
    haul_end TIMESTAMPTZ,
    pos_start_lat_dec NUMERIC(8,6),
    pos_start_lon_dec NUMERIC(8,6),
    pos_stop_lat_dec NUMERIC(8,6),
    pos_stop_lon_dec NUMERIC(8,6),
    fishing_time NUMERIC(5,2),
    determination_method CHAR(20),
    effort_count NUMERIC(18,6),
    effort_unit CHAR(10),
    sample_size NUMERIC(18,6),
    sample_unit CHAR(10),
    species_list CHAR(20),
    reviewer_id CHAR(20),
    record_type CHAR(2),
    PRIMARY KEY (trip_code,station_number),
    FOREIGN KEY (trip_code) REFERENCES trip(trip_code));

CREATE TABLE IF NOT EXISTS catch (
    trip_code VARCHAR(20),
    station_number INT,
    obs_timestamp TIMESTAMPTZ,
    obs_lat_dec NUMERIC(8,6),
    obs_lon_dec NUMERIC(8,6),
    species CHAR(6),
    weight_unit_of_measure CHAR(2),
    length_code CHAR(2),
    weight_determined_by CHAR(10),
    weight DECIMAL(18,6), 
    length_class DECIMAL (18,6),
    count NUMERIC(20,6),
    catch_category CHAR(3),
    condition CHAR(20),
    sex CHAR(1),
    maturity_stage INT,
    maturity_staging_method CHAR(20),
    imagery_metadata VARCHAR(30),
    record_type CHAR(2),
    FOREIGN KEY (trip_code,station_number) REFERENCES haul (trip_code,station_number));

CREATE TABLE IF NOT EXISTS other_events (
    trip_code VARCHAR(20),
    station_number INT,
    event_category_code CHAR(12),
    event_code CHAR(16),
    event_start_timestamp TIMESTAMPTZ,
    pos_start_lat_dec NUMERIC(8,6),
    pos_start_lon_dec NUMERIC(8,6),
    event_value INT,
    event_comments CHAR(100),
    FOREIGN KEY (trip_code) REFERENCES trip (trip_code),
    FOREIGN KEY (trip_code,station_number) REFERENCES haul (trip_code,station_number));

CREATE TABLE IF NOT EXISTS sensor (
    trip_code VARCHAR(20),
    sensor_id VARCHAR(20),
    sensor_type CHAR(40),
    timestamp TIMESTAMPTZ,
    sensor_field CHAR(40),
    sensor_value NUMERIC (8,5),
    units CHAR(20),
    collection_type CHAR(20),
    FOREIGN KEY (trip_code) REFERENCES trip (trip_code));

    
