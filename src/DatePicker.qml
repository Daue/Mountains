import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Controls 1.4

Dialog {
    property alias selectedDate: calendar.selectedDate

    title: "Data zdobycia"
    standardButtons: Dialog.Ok | Dialog.Cancel
    modal: true

    Calendar {
        id: calendar
    }
}
