import QtQuick 2.0

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
        text: model.name
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

    Behavior on color {
         PropertyAnimation{ duration: 50 }
    }
}



/*##^##
Designer {
    D{i:0;height:50;width:150}
}
##^##*/
