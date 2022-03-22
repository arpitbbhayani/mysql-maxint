MySQL ID hits the max value.
===

GitHub on May 5, 00:45 UTC faced an outage that lasted for two hours and 24 minutes. The outage was related to database, because of which the applications started throwing 5xx. The root cause of the outage was that the auto-incrementing ID column reached its max value because of which the clients were not able to insert new rows in the table.

A detailed dissection of the outage and possible solutions can be found at VIDEO_LINK.

This repository contains the SQL scripts with necessary comments helping the readers understand what happens when MySQL integer hits its limit for MySQL 8, just to mimic what could have happened.
