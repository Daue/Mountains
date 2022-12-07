import QtQuick 2.0

Rectangle
{
    property alias model: _list.model

    ListView
    {
        id: _list

        spacing: 2
        anchors.fill: parent
        anchors.margins: 2

        delegate: Rectangle {
            width: ListView.view.width
            height: 20

            Text{
                anchors.centerIn: parent
                font.bold: true
                text: model.name
            }

            Text {
                anchors.top: parent.top
                anchors.topMargin: 2
                anchors.right: parent.right
                anchors.rightMargin: 2

                text: model.height
                font.pointSize: 7
                opacity: 0.6
            }

            radius: 5
            color: "whitesmoke"
            border.width: 1
            border.color: "lightgray"
        }
    }
}
