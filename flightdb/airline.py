#!python2
#!/usr/bin/python
# -*- coding: cp1252 -*-
from datetime import datetime, timedelta

import pyodbc as db
conn = db.connect('DRIVER={ODBC Driver 13 for SQL Server}; SERVER=.; Trusted_Connection=yes; DATABASE=master')

# to validate the connection, there is no need to change the following line
# cur.execute('SELECT username from dbo.helpdesk')
# row = cur.fetchone()
# while row:
 #   print "SQL Server standard login name= %s" % (row[0])
 #  row = cur.fetchone()

# Intro to Application
print "********************************************************************************"
print "                     Hello, Welcome to the Airline Database                     "
print "********************************************************************************"

# Create Profile for a New Passenger
def newPassenger():
    cursor1 = conn.cursor()
    cursor2 = conn.cursor()

    first = raw_input("Please enter your first name: ")
    last = raw_input ("Please enter your last name: ")
    cursor1.execute('SELECT MAX(passenger_id) FROM Passenger')
    result = cursor1.fetchall()
    result = int(str(result).strip('[](), '))
    print "Max passenger id:",result
    new_id= (int(result)+1)
    print "New passenger information:\n\tFirst Name:",first,"\n\tLast Name:", last,"\n\tPassenger ID:",new_id
    confirm = raw_input("Submit? (yes or no): ")
    if confirm == 'yes':
        print ("adding data...")
        passenger = cursor2.execute("INSERT INTO Passenger(passenger_id, first_name, last_name, miles) VALUES (%d, '%s', '%s', %d)" %(new_id, first, last, 0))
        conn.commit()
        print "The profile for passenger", new_id, first, last," was created."
    else:
        print "Data not added."
    cursor1.close()
    cursor2.close()
    return

# finding passengers and available seats for specific flight instance
def seatsAvail():
    cursor1 = conn.cursor()
    cursor2= conn.cursor()
    cursor3 = conn.cursor()

    code = raw_input ("Please enter your flight code: ")
    depart = raw_input ("Please enter your departure date(format as YYYYMMDD): ")

    cursor1.execute("SELECT COUNT(*) From Booking, Flight_Instance, Passenger WHERE booking.flight_code='%s' AND booking.depart_date = '%s' AND Passenger.passenger_id = Booking.passenger_id AND booking.flight_code = flight_instance.flight_code AND booking.depart_date = flight_instance.depart_date" %(code, depart))
    counts=cursor1.fetchone()
    counts = int(str(counts).strip('[](), '))
    if counts < 1:
        print "This flight instance does not exist."
    else:
        cursor2.execute("SELECT Passenger.passenger_id, Passenger.first_name, Passenger.last_name, Passenger.miles From Booking, Flight_Instance, Passenger WHERE booking.flight_code='%s' AND booking.depart_date = '%s' AND Passenger.passenger_id = Booking.passenger_id AND booking.flight_code = flight_instance.flight_code AND booking.depart_date = flight_instance.depart_date" %(code, depart))
        row = cursor2.fetchone()
        while row: #print row
            print "Passenger ID: %d First Name: %s Last Name: %s Miles: %d" %(row[0], row[1].strip(), row[2].strip(), row[3])
            row = cursor2.fetchone()
        cursor3.execute("SELECT DISTINCT(Flight_Instance.available_seats) From Booking, Flight_Instance, Passenger WHERE Booking.flight_code='%s' AND Booking.depart_date = '%s' AND booking.flight_code = flight_instance.flight_code AND booking.depart_date = flight_instance.depart_date" %(code, depart))
        res = cursor3.fetchall()
        res = int(str(res).strip('[](), '))
        print "The number of seats left available for this flight is: ",res

    cursor1.close()
    cursor2.close()
    cursor3.close()
    return

# for booking a flight
def addRecords():
    mycursor1 = conn.cursor()
    mycursor2 = conn.cursor()
    mycursor3 = conn.cursor()
    mycursor4 = conn.cursor()
    mycursor5 = conn.cursor()
    mycursor6 = conn.cursor()
    mycursor7 = conn.cursor()
    mycursor8 = conn.cursor()
    mycursor9 = conn.cursor()
    mycursor10 = conn.cursor()
    mycursor11 = conn.cursor()
    mycursor12 = conn.cursor()
    mycursor13 = conn.cursor()
    mycursor14 = conn.cursor()
    mycursor15 = conn.cursor()
    mycursor16 = conn.cursor()
    mycursor17 = conn.cursor()
    mycursor18 = conn.cursor()

    pid = int(raw_input("Please enter your passenger id: "))
    mycursor1.execute ("SELECT COUNT(*) From Passenger Where Passenger.passenger_id = %d" %(pid))
    check = mycursor1.fetchall()
    check = int(str(check).strip('[](), '))
    if check < 1:
        print "Passenger ID does not exist. Please create a profile before booking a flight."
    else:
        trip = raw_input("Please enter your travel type (multi or single): ")
        if trip == 'single':
            print ("Single Trip")
            code = raw_input ("Please enter your flight code: ")
            depart = raw_input ("Please enter your departure date(format as YYYYMMDD): ")

            mycursor2.execute("SELECT COUNT(*) From Flight_Instance WHERE flight_code = '%s' AND depart_date='%s'" %(code, depart))
            count = mycursor2.fetchall()
            count = int(str(count).strip('[](), '))
            if count < 1:
                print "This flight and date combination does not exist."
            else:
                mycursor3.execute("SELECT Flight_Instance.available_seats From Flight_Instance WHERE flight_code = '%s' AND depart_date='%s'" %(code, depart))
                res = mycursor3.fetchall()
                res = str(res).strip('[](), ')
                print "The number of seats left available for this flight is: ",res
                if res <1:
                    print "There are no more seats left for this flight."
                mycursor4.execute("SELECT Booking.passenger_id, Flight_Instance.flight_code, Flight_Instance.depart_date FROM Booking, Flight_Instance WHERE Booking.passenger_id = %d AND Booking.flight_code='%s' AND Booking.depart_date = '%s' AND booking.flight_code = flight_instance.flight_code AND booking.depart_date = flight_instance.depart_date " %(pid, code, depart))
                row = mycursor4.fetchone()
                while row:
                    print "Passenger ID: %d\t Flight Code: %s\t Departure Date: %s" %(row[0], row[1], row[2])
                    row = mycursor4.fetchone()
                confirm = raw_input("Submit? (yes or no): ")
                if confirm == 'yes':
                    print ("booking flight...")
                    mycursor5.execute("INSERT INTO Booking(passenger_id, flight_code, depart_date) VALUES (%d, '%s', '%s')" %(pid, code, depart))
                    #conn.commit()
                    print "The flight for passenger", pid,"flight", code, "departing on", depart, "has been booked."
                else:
                    print("Flight not booked.")
            #conn.rollback()

        elif trip == 'multi':
            print ("Multi Trip")
            code1 = raw_input ("Please enter your first flight code: ")
            mycursor6.execute("SELECT DISTINCT COUNT(*) FROM Flight,Flight_Instance WHERE Flight.flight_code = '%s' AND Flight.flight_code = Flight_Instance.flight_code AND Flight.arrival_iata IN( SELECT Flight.departure_iata FROM Flight)" %(code1))
            cnt = mycursor6.fetchall()
            cnt = int(str(cnt).strip('[](), '))
            if cnt < 1:
                print "This flight is not available for multi-flight."
            else:
                mycursor7.execute("SELECT DISTINCT Flight.flight_code, Flight.departure_iata, Flight.arrival_iata, Flight_Instance.depart_date, available_seats FROM Flight,Flight_Instance WHERE Flight.flight_code = '%s' AND Flight.flight_code = Flight_Instance.flight_code AND Flight.arrival_iata IN( SELECT Flight.departure_iata FROM Flight)" %(code1))
                rows = mycursor7.fetchone()
                while rows:
                    print "Flight Code: %s\t Departing Airport: %s\t Arriving Airport: %s\t Departure Date: %s\t Available Seats: %d" %(rows[0], rows[1], rows[2], rows[3], rows[4])
                    rows = mycursor7.fetchone()
                depart1 = raw_input ("Please enter your first departure date(format as YYYYMMDD): ")
                mycursor8.execute("SELECT COUNT(available_seats) From Flight_Instance WHERE flight_code = '%s' AND depart_date='%s'" %(code1, depart1))
                res3 = mycursor8.fetchall()
                res3 = int(str(res3).strip('[](), '))
                if res3 < 1:
                    print "The flight is not offered on this date."
                else:
                    mycursor9.execute("SELECT Flight_Instance.available_seats From Flight_Instance WHERE flight_code = '%s' AND depart_date='%s'" %(code1, depart1))
                    res2 = mycursor9.fetchall()
                    res2 = str(res2).strip('[](), ')
                    print "The number of seats left available for this flight is: ",res2
                    if res2 <1:
                        print "There are no more seats left for this flight."
                    print ("Second Part of Flight")
                    mycursor10.execute("SELECT DISTINCT Flight.flight_code, Flight.departure_iata, Flight.arrival_iata, Flight_Instance.depart_date, available_seats FROM Flight,Flight_Instance WHERE Flight.flight_code = '%s' AND Flight.flight_code = Flight_Instance.flight_code AND Flight.arrival_iata IN( SELECT Flight.departure_iata FROM Flight)" %(code1))
                    rowsval = mycursor10.fetchone()
                    mycursor11.execute("SELECT Flight_Instance.flight_code, Flight_Instance.depart_date, Flight.departure_iata, Flight.arrival_iata, Flight_Instance.available_seats FROM Flight_Instance, Flight WHERE Flight.departure_iata ='%s' AND flight.flight_code = Flight_Instance.flight_code" %(rowsval[2]))
                    second= mycursor11.fetchone()
                    while second:
                        print "Flight Code: %s\t Departure Date: %s\t Departing Airport: %s\t Arriving Airport: %s Available Seats: %d" %(second[0], second[1], second[2], second[3], second[4])
                        second = mycursor11.fetchone()
                    code2 = raw_input ("Please enter your second flight code: ")

                    print "The possible date selection for the selection flight is: "
                    mycursor12.execute ("SELECT DISTINCT Flight_Instance.flight_code, Flight_Instance.depart_date, Flight_Instance.available_seats, Flight.departure_iata FROM  Flight_Instance, Flight WHERE Flight.flight_code='%s' AND Flight.flight_code = flight_instance.flight_code" %(code2))
                    rowsval2 = mycursor12.fetchone()
                    if rowsval[2] != rowsval2[3]:
                        print "Flight not possible."
                    else:
                        mycursor13.execute ("SELECT DISTINCT Flight_Instance.flight_code, Flight_Instance.depart_date, Flight_Instance.available_seats, Flight.departure_iata FROM  Flight_Instance, Flight WHERE Flight.flight_code='%s' AND Flight.flight_code = flight_instance.flight_code" %(code2))
                        row5 = mycursor13.fetchone()
                        while row5:
                            print "Flight Code: %s\t Departure Date: %s\t Available Seats: %d" %(row5[0], row5[1], row5[2])
                            row5 = mycursor13.fetchone()

                        depart2 = raw_input ("Please enter your second departure date(format as YYYYMMDD): ")
                        mycursor14.execute("SELECT COUNT(*) From Flight_Instance WHERE flight_code = '%s' AND depart_date='%s'" %(code2, depart2))
                        count3 = mycursor14.fetchall()
                        count3 = int(str(count3).strip('[](), '))
                        if count3 < 1:
                            print "The flight is not offered on this date."
                        else:
                            mycursor15.execute("SELECT Flight_Instance.available_seats From Flight_Instance WHERE flight_code = '%s' AND depart_date='%s'" %(code2, depart2))
                            res3 = mycursor15.fetchall()
                            res3 = str(res3).strip('[](), ')
                            print "The number of seats left available for this flight is: ",res3
                            if res3 <1:
                                print "There are no more seats left for this flight."
                            # conn.rollback()
                            mycursor16.execute("SELECT Booking.passenger_id, Flight_Instance.flight_code, Flight_Instance.depart_date FROM Booking, Flight_Instance WHERE Booking.passenger_id = '%s' AND Booking.flight_code='%s' AND Booking.depart_date = '%s' AND booking.flight_code = flight_instance.flight_code AND booking.depart_date = flight_instance.depart_date " %(pid, code2, depart2))
                            row3 = mycursor16.fetchone()
                            while row3:
                                print "Passenger ID: %d\t Flight Code: %s\t Departure Date: %s\t " %(row3[0], row3[1], row3[2])
                                row3 = mycursor16.fetchone()
                            if depart2 > depart1:
                                confirm = raw_input("Submit? (yes or no): ")
                                if confirm == 'yes':
                                    print ("booking flight...")
                                    mycursor17.execute("INSERT INTO Booking(passenger_id, flight_code, depart_date) VALUES (%d, '%s', '%s')" %(pid, code1, depart1))
                                    mycursor18.execute("INSERT INTO Booking(passenger_id, flight_code, depart_date) VALUES (%d, '%s', '%s')" %(pid, code2, depart2))
                                # conn.commit()
                                    print "The flight for passenger", pid,"flight", code1, "departing on", depart1, "and flight",code2,"departing on",depart2,"has been booked."
                                else:
                                    print("Flight not booked.")
                                # conn.rollback()
                            else:
                                print ("Invalid departure date.")
                            # conn.rollback()
    mycursor1.close()
    mycursor2.close()
    mycursor3.close()
    mycursor4.close()
    mycursor5.close()
    mycursor6.close()
    mycursor7.close()
    mycursor8.close()
    mycursor9.close()
    mycursor10.close()
    mycursor11.close()
    mycursor12.close()
    mycursor13.close()
    mycursor14.close()
    mycursor15.close()
    mycursor16.close()
    mycursor17.close()
    mycursor18.close()

    return

#main menu

loop = True
while loop:
    options = raw_input("What would you like to do?\n\tTo Create Profile for a New Passenger, please enter 1\n\tTo View Passengers for a Flight Instance, please enter 2\n\tTo Add Booking Records, please enter 3\n\tTo Exit, please enter 4\nPlease enter your choice [1-4]: ")
    if options == '1':
        print "Create New Profile"
        newPassenger()
    elif options == '2':
        print "Check Available Seats"
        seatsAvail()
    elif options == '3':
        print "Add Booking Records"
        addRecords()
    elif options == '4':
        print "Good-bye."
        loop = False
    else:
        print "Input invalid. Please try again."
        raw_input("To Create Profile for a New Passenger, please enter 1\nTo View Passengers for a Flight Instance, please enter 2\nTo Add Booking Records, please enter 3\nWhat would you like to do: ")
