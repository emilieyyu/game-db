
## About
The purpose of this application is for users to:
1. Create New Profile
2. View Passengers for specific Flight Instances
3. Add Single Flight or Multi Flight to the Airline Database

## Dependencies:
- CSIL Windows Terminal Server
    - leto.csil.sfu.ca with valid connection
- CYPRESS
    - cypress.csil.sfu.ca with valid connection
- Python 2.7
    - import datetime
    - import pymssql

## How to Use
Launch the application by double clicking the '.py' file or running it through the Python version 2.7 Shell IDLE. An interface of the application will show up with a menu of possible actions. The program will terminate if user chooses to exit, or manually closing the command line application window.

#### For Create Profile of a New Passenger:
User will be prompt for first and last name, and be given a passenger ID. Remember this ID because this is what will be needed for booking flights in the future. User will be able to confirm entered data and submit data, so the passenger's data can be added to the database.

#### For Finding List of Passengers and Available Seats of Specified Flight Instance:
User will be prompt for flight code and departure date that they wish to lookup. The format flight code is 'JAXXX', where X represents a number, and the format of the departure date is 'YYYYMMDD'. This will display a list of all the passenger's passenger ID, first name, last name on that specific flight code, and the number of seats available.
```
Example:
Flight Code: JA100
Departure Date: April 15th, 2018 => 20180415
```

#### For Booking a Flight:
User will first be prompt for their Passenger ID, and then be asked whether they are booking a single (one-way) trip, or a multi-trip flight. User will be asked to create a profile first if they do not have a valid Passenger ID.
    
    Single Trip: 
        User enters flight code and departure (format same as previous), and while there are still seats available on the flight, the user can confirm and book the flight.
    
    Multi Trip:
        (for airline.py)
        User enters flight code and departure (format same as previous) of the first part of their trip, and while the flight selected allows for multi trip flights, the user can proceed to enter details of the second part of their flight. If the flight selected does not allow for multi trip, there are no more seats, or if the second departure date entered is before the first departure date, then the passenger will not be able to successfully book their flight.
        (for airtest.py)
        User enters flight code and departure (format same as previous) of the first part of their trip and as long as that flight instance exists, the user can proceed to enter details of the second part of their flight. Once the user enters the second part of their trip, the program will show the possible dates. If the flight selected does not exist, the date selected is not offered, there are no more seats, or if the second departure date entered is before the first departure date, then the passenger will not be able to successfully book their flight.

## Additional Notes:
- Assume that the user knows the flight code, departing dates and do not need a lookup for each flight instance.
- For multi trip, 'airline.py' assumes that the second part of flight must be in same place as the destination of the first part, eg. A->B, B->C and 'airtest.py' assumes that multiple flights can take the form of A->B, C->D or A->B, B->C .
- For entering departure dates, assume that given a list of valid dates, user will enter one that is valid, and not one not listed.
