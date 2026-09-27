#include <iostream>
#include <iomanip>
#include <string>
#include <ctime>
#include <cmath>
#include <limits>

using namespace std;

const int TOTAL_SLOTS = 30;
const double RATE_PER_HOUR = 80.0;

struct Vehicle {
    string registration;
    string type;
    string owner;
    int slot;
    time_t entryTime;
    bool parked;
};

struct ParkingSlot {
    string slotNumber;
    bool occupied;
};

Vehicle vehicles[100];
ParkingSlot slots[TOTAL_SLOTS];

int vehicleCount = 0;

void initializeSlots() {
    for (int i = 0; i < TOTAL_SLOTS; i++) {
        slots[i].slotNumber = string("S") + (i < 9 ? "0" : "") + to_string(i + 1);
        slots[i].occupied = false;
    }
}

int findAvailableSlot() {
    for (int i = 0; i < TOTAL_SLOTS; i++) {
        if (!slots[i].occupied)
            return i;
    }
    return -1;
}

int findVehicle(string registration) {
    for (int i = 0; i < vehicleCount; i++) {
        if (vehicles[i].registration == registration &&
            vehicles[i].parked) {
            return i;
        }
    }
    return -1;
}

void showSlots() {
    cout << "\n========== PARKING SLOTS ==========\n";

    for (int i = 0; i < TOTAL_SLOTS; i++) {
        cout << slots[i].slotNumber << " : "
             << (slots[i].occupied ? "OCCUPIED" : "AVAILABLE")
             << "    ";

        if ((i + 1) % 3 == 0)
            cout << endl;
    }
}

void vehicleEntry() {
    if (vehicleCount >= 100) {
        cout << "\nVehicle storage is full.\n";
        return;
    }

    int slotIndex = findAvailableSlot();

    if (slotIndex == -1) {
        cout << "\nParking lot is FULL.\n";
        return;
    }

    Vehicle v;

    cout << "\n========== VEHICLE ENTRY ==========\n";

    cout << "Registration number: ";
    cin >> v.registration;

    if (findVehicle(v.registration) != -1) {
        cout << "This vehicle is already parked.\n";
        return;
    }

    cin.ignore(numeric_limits<streamsize>::max(), '\n');

    cout << "Vehicle type: ";
    getline(cin, v.type);

    cout << "Owner/Driver name: ";
    getline(cin, v.owner);

    v.slot = slotIndex;
    v.entryTime = time(nullptr);
    v.parked = true;

    vehicles[vehicleCount] = v;
    slots[slotIndex].occupied = true;

    vehicleCount++;

    cout << "\n========== ENTRY SUCCESSFUL ==========\n";
    cout << "Registration : " << v.registration << endl;
    cout << "Vehicle type : " << v.type << endl;
    cout << "Owner/Driver : " << v.owner << endl;
    cout << "Assigned slot: " << slots[slotIndex].slotNumber << endl;

    cout << "\nBarrier status: CLOSED\n";
    cout << "Vehicle may enter the parking area.\n";
}

void vehicleExit() {
    string registration;

    cout << "\n========== VEHICLE EXIT ==========\n";
    cout << "Enter registration number: ";
    cin >> registration;

    int index = findVehicle(registration);

    if (index == -1) {
        cout << "\nVehicle not found or already exited.\n";
        return;
    }

    time_t exitTime = time(nullptr);

    double minutes = difftime(exitTime, vehicles[index].entryTime) / 60.0;

    int billableHours = max(1, (int)ceil(minutes / 60.0));

    double amount = billableHours * RATE_PER_HOUR;

    cout << fixed << setprecision(2);

    cout << "\n========== EXIT DETAILS ==========\n";
    cout << "Registration : " << vehicles[index].registration << endl;
    cout << "Vehicle type : " << vehicles[index].type << endl;
    cout << "Parking slot : " << slots[vehicles[index].slot].slotNumber << endl;
    cout << "Duration     : " << (int)minutes << " minutes" << endl;
    cout << "Billable time: " << billableHours << " hour(s)" << endl;
    cout << "Rate         : KSh " << RATE_PER_HOUR << " per hour" << endl;
    cout << "Amount due   : KSh " << amount << endl;

    char payment;

    cout << "\nConfirm payment? (Y/N): ";
    cin >> payment;

    if (payment == 'Y' || payment == 'y') {

        cout << "\nPayment successful.\n";

        slots[vehicles[index].slot].occupied = false;
        vehicles[index].parked = false;

        cout << "Slot "
             << slots[vehicles[index].slot].slotNumber
             << " is now AVAILABLE.\n";

        cout << "\nBarrier status: OPEN\n";
        cout << "Vehicle EXIT permitted.\n";

        cout << "\nThank you for using the parking system.\n";
    }
    else {
        cout << "\nPayment cancelled.\n";
        cout << "Barrier status: CLOSED\n";
        cout << "Vehicle cannot exit until payment is made.\n";
    }
}

void showParkedVehicles() {
    cout << "\n========== PARKED VEHICLES ==========\n";

    bool found = false;

    for (int i = 0; i < vehicleCount; i++) {
        if (vehicles[i].parked) {
            found = true;

            cout << "\nRegistration : " << vehicles[i].registration;
            cout << "\nVehicle type : " << vehicles[i].type;
            cout << "\nOwner/Driver : " << vehicles[i].owner;
            cout << "\nSlot         : "
                 << slots[vehicles[i].slot].slotNumber << "\n";
        }
    }

    if (!found)
        cout << "\nNo vehicles are currently parked.\n";
}

void showSystemSummary() {
    int available = 0;
    int occupied = 0;

    for (int i = 0; i < TOTAL_SLOTS; i++) {
        if (slots[i].occupied)
            occupied++;
        else
            available++;
    }

    cout << "\n========== SYSTEM SUMMARY ==========\n";
    cout << "Total slots     : " << TOTAL_SLOTS << endl;
    cout << "Available slots : " << available << endl;
    cout << "Occupied slots  : " << occupied << endl;
    cout << "Rate            : KSh " << RATE_PER_HOUR
         << " per hour\n";
}

int main() {

    initializeSlots();

    int choice;

    cout << "============================================\n";
    cout << "     SMART PARKING MANAGEMENT SYSTEM\n";
    cout << "============================================\n";

    do {
        cout << "\n\n========== MAIN MENU ==========\n";
        cout << "1. Show parking slots\n";
        cout << "2. Vehicle entry\n";
        cout << "3. Vehicle exit / payment\n";
        cout << "4. Show parked vehicles\n";
        cout << "5. System summary\n";
        cout << "6. Exit program\n";
        cout << "Choose option: ";

        cin >> choice;

        switch (choice) {

            case 1:
                showSlots();
                break;

            case 2:
                vehicleEntry();
                break;

            case 3:
                vehicleExit();
                break;

            case 4:
                showParkedVehicles();
                break;

            case 5:
                showSystemSummary();
                break;

            case 6:
                cout << "\nSystem closed.\n";
                break;

            default:
                cout << "\nInvalid option. Please try again.\n";
        }

    } while (choice != 6);

    return 0;
}
