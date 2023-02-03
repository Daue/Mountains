import QtQuick 2.0

Rectangle {
    id: root
    property int mountainId : -1

    function open(_mountainId) {
        root.x = parent.width - root.width
        root.mountainId = _mountainId;
    }

    function close() {
       root.x = parent.width
    }

    x: parent.width
    width: 300
    height: 90
    anchors.bottom: parent.bottom
    border.width: 1
    border.color: "black"
    color: "white"

    Column {

        anchors.fill: parent
        anchors.topMargin: 10
        spacing: 10

        Row
        {
            x: 10
            spacing: 10

            Text {
                id: _mountainNameText
                font.bold: true
                font.pointSize: 13
            }

            Text {
                id: _mountainHeightText
                anchors.bottom: _mountainNameText.bottom
                font.pointSize: 11
            }
        }

        Rectangle {
            color: "black"
            height: 1
            width: parent.width - 20
            anchors.horizontalCenter: parent.horizontalCenter
            opacity: 0.4
        }

        Row {
            x: 30
            Text {
                text: "Data zdobycia: ???"
                font.pointSize: 10
            }
        }

    }

    onMountainIdChanged: {
        if ( root.mountainId == -1 )
        {
            _mountainNameText.text = "";
            _mountainHeightText.text = "";
            return;
        }

        var mountainInfo = mountainsModel.getMountainById( root.mountainId );
        _mountainNameText.text = mountainInfo.name;
        _mountainHeightText.text = "(" + mountainInfo.height + " m n.p.m.)";
    }

    Behavior on x {
         PropertyAnimation{ duration: 250; easing.type: Easing.OutCubic  }
    }
}
