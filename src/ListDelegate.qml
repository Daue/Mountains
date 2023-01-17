import QtQuick 2.0
import QtQuick.Controls 2.0

import mountains 1.0

Rectangle {
    id: root
    width: ListView.view.width
    height: 60

    color:
          ListView.isCurrentItem
        ? "#8890ee90"
        : mouseArea.containsMouse ? "#2290ee90" : "white"

    Text{
        id: _name
        font.bold: true
        font.pointSize: 10
        text: ( model.index + 1 ) + ". " + model.name
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 6
    }

    Rectangle {
        height: childrenRect.height
        anchors.top: _name.bottom
        anchors.topMargin: 3
        anchors.left: _name.left

        Column
        {
            Text {
                text: model.height + " m n.p.m."
            }
            Text {
                text: model.range
            }
        }
    }

    Rectangle {
        width: parent.width - 8
        height: 1
        color: "black"
        opacity: 0.4

        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: root.ListView.view.currentIndex = index
    }

    CheckBox {
        anchors.right: parent.right
        anchors.top: parent.top
        checked: settings.getMountainUserData( model.id ).enabled
        checkable: true
        indicator.width: 16
        indicator.height: 16

        onCheckedChanged:
        {
            var data = settings.getMountainUserData( model.id );
            data.enabled = checked;
            settings.setMountainUserData( model.id, data );
        }
    }

    Behavior on color {
         PropertyAnimation{ duration: 50 }
    }
}



/*##^##
Designer {
    D{i:0;height:50;width:150}
}
##^##*/
