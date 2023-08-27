-- Add down migration script here
DROP TRIGGER reservation_trigger ON rsvp.reservations;
DROP FUNCTION rsvp.reservation_changes_trigger();
DROP TABLE rsvp.reservation_changes CASCADE;
