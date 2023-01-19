import QtQuick 2.0

Rectangle {
    id: root

    function open() {
        root.x = parent.width - root.width
    }

    function close() {
       root.x = parent.width
    }

    x: parent.width
    width: 300
    height: 100
    anchors.bottom: parent.bottom
    border.width: 1
    border.color: "black"
    color: "white"

    Behavior on x {
         PropertyAnimation{ duration: 250; easing.type: Easing.OutCubic  }
    }
}
