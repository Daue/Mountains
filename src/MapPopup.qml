import QtQuick 2.15

Item {

    property alias title : _title.text
    property alias description: _description.text
    property int margin: 15

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
        radius: 5

        Column
        {
            id: textLayout
            width: childrenRect.width
            height: childrenRect.height
            anchors.centerIn: parent
            spacing: 5

            Text {
                id: _title
                font.bold: true
                font.pointSize: 10
            }

            Text {
                id: _description
                font.pointSize: 9
            }

            onChildrenRectChanged: {
               root.width = childrenRect.width + root.margin
               root.height = childrenRect.height + root.margin
            }
        }
    }

    Behavior on opacity {
         PropertyAnimation{ duration: 200 }
    }
}

