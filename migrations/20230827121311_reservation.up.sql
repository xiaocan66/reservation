-- Add up migration script here
CREATE TYPE rsvp.reservation_status AS ENUM (
    'UNKNOWN',
    'PENDING',
    'CONFIRMED',
    'CANCELED'
);
CREATE TYPE rsvp.reservation_update_type AS ENUM (
    'UNKNOWN',
    'CREATE',
    'UPDATE',
    'DELETE'
);
CREATE TABLE rsvp.reservations (
    id uuid NOT NULL DEFAULT gen_random_uuid(),
    user_id varchar(64) NOT NULL,

    resource_id varchar(64) NOT NULL,
    timespan TSRANGE NOT NULL,

    create_time timestamp with time zone NOT NULL,
    update_time timestamp with time zone NOT NULL,

    status rsvp.reservation_status NOT NULL,

    note text ,
    CONSTRAINT reservations_pkey PRIMARY KEY (id),
    CONSTRAINT reservations_conflict EXCLUDE USING gist (
        resource_id WITH =,
        timespan WITH &&
    )
);


CREATE INDEX reservations_user_id_idx ON rsvp.reservations(resource_id);
CREATE INDEX reservations_resource_id_idx ON rsvp.reservations(user_id);
