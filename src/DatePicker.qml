import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Controls 1.4

Dialog {
    title: "Data zdobycia"
    standardButtons: Dialog.Ok | Dialog.Cancel
    modal: true

    Calendar {
        //anchors.centerIn: parent
        //visibleYear: 2022
    }
}
