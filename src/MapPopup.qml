import QtQuick 2.15

Item {

    property alias title : _title.text
    property alias description: _description.text
    property int fontSize: 10

    id: root
    opacity: 0.0

    function show(){
        root.opacity = 1.0;
    }

    function hide() {
        root.opacity = 0.0;
    }

    Rectangle {
        id: rect
        anchors.fill: parent
        color: "white"
        border.color: "black"
        border.width: 1
        radius: 6

        Column
        {
            id: textLayout
            width: childrenRect.width
            height: childrenRect.height
            anchors.centerIn: parent

            Text {
                id: _title
                font.bold: true
                font.pointSize: root.fontSize
            }

            Text {
                id: _description
                font.pointSize: root.fontSize
            }

            onChildrenRectChanged: {
               root.width = childrenRect.width + 10
               root.height = childrenRect.height + 10
            }
        }
    }

    Behavior on opacity {
         PropertyAnimation{ duration: 200 }
    }
}

