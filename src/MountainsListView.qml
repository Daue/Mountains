import QtQuick 2.0

Rectangle
{
    property alias model: list.model

    ListView
    {
        id: list

        spacing: 4
        anchors.fill: parent
        anchors.margins: 10

        delegate: Rectangle {
            width: ListView.view.width
            height: 80

            Text {
                anchors.centerIn: parent
                text: model.id
            }

            radius: 5
            color: "whitesmoke"
            border.width: 1
            border.color: "lightgray"
        }
    }
}
