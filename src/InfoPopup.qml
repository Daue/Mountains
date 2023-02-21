import QtQuick 2.0

Rectangle {
    id: root
    property int mountainId : -1
    signal editClicked

    function open(_mountainId) {
        root.x = parent.width - root.width
        root.mountainId = _mountainId;
        root.update();
    }

    function close() {
       root.x = parent.width
    }

    function update() {
        if ( root.mountainId === -1 )
        {
            _mountainNameText.text = "";
            _mountainHeightText.text = "";
            _dateText.text = "Data zdobycia: ??-??-????";
            return;
        }

        var mountainInfo = mountainsModel.getMountainById( root.mountainId );
        _mountainNameText.text = mountainInfo.name;
        _mountainHeightText.text = "(" + mountainInfo.height + " m n.p.m.)";

        var mountainUserData = settings.getMountainUserData( root.mountainId )
        if ( mountainUserData.date.toLocaleDateString() !== "" )
            _dateText.text = "Data zdobycia: " + mountainUserData.date.toLocaleDateString( Qt.locale(), "dd MMMM yyyy" )
        else
            _dateText.text = "Data zdobycia: ??-??-????";
    }

    x: parent.width
    width: 300
    height: 120
    anchors.bottom: parent.bottom
    border.width: 1
    border.color: "black"
    color: "white"


    MouseArea {
        anchors.fill: parent
    }

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
                id: _dateText
                font.pointSize: 10
            }
        }
    }

    Image {
        id: _editButton
        anchors.margins: 4
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: mouseArea.containsMouse ? anchors.margins + 2 : anchors.margins
        anchors.bottomMargin: mouseArea.containsMouse ? anchors.margins + 2 : anchors.margins
        source: "qrc:/img/res/edit_icon.png"

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: root.editClicked()
            hoverEnabled: true
        }
    }

    onMountainIdChanged: root.update()

    Behavior on x {
         PropertyAnimation{ duration: 250; easing.type: Easing.OutCubic  }
    }
}
