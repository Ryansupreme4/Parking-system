DATABASE DESIGN

The parking management system can be organized using the following tables:

1. VEHICLES
Fields:
- Vehicle ID
- Registration Number
- Vehicle Type
- Owner Name

2. PARKING SLOTS
Fields:
- Slot ID
- Slot Number
- Status

3. PARKING SESSIONS
Fields:
- Session ID
- Vehicle ID
- Slot ID
- Entry Time
- Exit Time

4. PARKING PAYMENTS
Fields:
- Payment ID
- Session ID
- Amount
- Payment Status

5. BARRIERS
Fields:
- Barrier ID
- Barrier Type
- Status


PARKING RATE

The parking charge used by the system is KSh 80 per hour.


TABLE DESCRIPTIONS

Vehicles:
Stores information about vehicles using the parking area.

Parking Slots:
Keeps track of which parking slots are available or occupied.

Parking Sessions:
Records when a vehicle enters and leaves the parking area.

Parking Payments:
Stores information about payments made for parking.

Barriers:
Keeps track of whether the entrance or exit barrier is open or closed.


RELATIONSHIPS BETWEEN TABLES

- A vehicle can have one or more parking sessions.
- A parking slot can be assigned to a vehicle during a parking session.
- A parking session is connected to the payment made by the vehicle.
- The barrier status changes when a vehicle enters or exits the parking area.