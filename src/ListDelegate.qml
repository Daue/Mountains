import QtQuick 2.0
import QtQuick.Controls 2.15

Rectangle {

    property alias flagVisible: _flagImage.visible;

    id: root
    //border.color: "darkgrey"
    //border.width: 1
    //radius: 1

    Rectangle {
        width: parent.width
        height: 1
        //border.color: "darkgrey"
        //border.width: 1
        color: "darkgrey"
    }

    color:
          ListView.isCurrentItem
        ? "#5590ee90"
        : mouseArea.containsMouse ? "#1190ee90" : "white"

    Text{
        id: _name
        font.bold: true
        font.pointSize: 10
        text: ( model.id + 1 ) + ". " + model.name
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 6
        anchors.leftMargin: 10
    }

    Rectangle {
        height: childrenRect.height
        anchors.top: _name.bottom
        anchors.topMargin: 2
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

    Image {
        id: _flagImage
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        source: "qrc:/img/res/flag.png"
        width: 30
        height: 30
        rotation: 20

        PropertyAnimation {
            id: _scaleAnimation
            target: _flagImage
            property: "scale"
            from: 2
            to: 1
            duration: 200
        }

        onVisibleChanged: _scaleAnimation.start()
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: root.ListView.view.currentIndex = index
    }

    Dialog {
        id: dialog
        title: "Dave"
        modal: true
        standardButtons: Dialog.Ok
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
