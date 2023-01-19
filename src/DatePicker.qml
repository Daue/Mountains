import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Controls 1.4

Rectangle {
    id: root
    property alias title: titleText.text

    //dave remove
    function open() {
        root.visible = true
    }

    width: childrenRect.width
    height: childrenRect.height
    visible: false
    color: "white"
    border {
        color: "green"
        width: 1
    }

    Column
    {
        spacing: 8

        Rectangle {
            width: root.width
            height: 30
            color: "green"

            Text {
                id: titleText
                anchors.centerIn: parent
                color: "white"
                font.pointSize: 12
                font.bold: true
            }

            MouseArea {
                anchors.fill: parent
                drag.target: root
            }
        }

        Calendar {
            id: calendar
            anchors.horizontalCenter: parent.horizontalCenter
         }

        Button {
            text: "Ok"
            anchors.right: calendar.right
            onClicked: root.visible = false
        }
    }

    //@dave remove
    onVisibleChanged: {
        root.width = childrenRect.width + 10
        root.height = childrenRect.height + 5
        root.x = ( parent.width - root.width )/2
        root.y = ( parent.height - root.height )/2
    }

    //dave dragable popup
//    contentItem: Rectangle{

//               Drag.active: true
//               MouseArea{
//                   anchors.fill: parent
//                   drag.target: parent
//               }
    // the content

}
