import QtQuick 2.15

Item {

    property alias text : _text.text

    id: root
    opacity: 0.0

    Rectangle {
        id: rect
        anchors.fill: parent
        color: "white"
        border.color: "black"
        border.width: 1
        radius: 6

        Text {
            id: _text
            font.bold: true
            anchors.centerIn: parent
        }
    }

    Behavior on opacity {
         PropertyAnimation{ duration: 200 }
    }

    onTextChanged: {
        root.width = _text.width + 10
        root.height = _text.height + 10
    }
}
