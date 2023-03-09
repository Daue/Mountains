import QtQuick 2.0
import QtQuick.Controls 2.0
import "managers.js" as Managers

Rectangle {
    id: root
    property int mountainId : -1
    property bool isOpened: false
    signal editClicked;
    signal checkedChanged( var _checked);

    function open(_mountainId) {
        root.mountainId = _mountainId;
        root.update();
        root.isOpened = true
        _xAnimation.start();
    }

    function close() {
        root.isOpened = false
       _xAnimation.start();
    }

    function update() {
        if ( root.mountainId === -1 )
        {
            _mountainNameText.text = "";
            _mountainHeightText.text = "";
            _mountainRangeText.text ="";
            _dateText.text = "Data zdobycia: ??-??-????";
            _checkBox.checked = false
            return;
        }

        var mountainInfo = mountainsModel.getMountainById( root.mountainId );
        var mountainUserData = settings.getMountainUserData( root.mountainId )

        _mountainNameText.text = mountainInfo.name;
        _mountainHeightText.text = "(" + mountainInfo.height + " m n.p.m.)";
        _mountainRangeText.text = mountainInfo.range;
        _checkBox.checked = mountainUserData.checked

        if ( mountainUserData.date.toLocaleDateString() !== "" )
            _dateText.text = "Data zdobycia: " + mountainUserData.date.toLocaleDateString( Qt.locale(), "dd MMMM yyyy" )
        else
            _dateText.text = "Data zdobycia: ??-??-????";
    }

    x: parent.width
    width: 300
    height: _checkBox.checked ? 110 : 70
    anchors.bottom: parent.bottom
    anchors.margins: 4
    border.width: 2
    border.color: "black"
    color: "white"
    radius: 12


    MouseArea {
        anchors.fill: parent
    }

    Column {

        anchors.fill: parent
        anchors.topMargin: 14
        spacing: 8

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

        Text {
            x: 10
            id: _mountainRangeText
            font.pointSize: 11
        }

        Rectangle {
            color: "black"
            height: 1
            width: parent.width - 20
            anchors.horizontalCenter: parent.horizontalCenter
            opacity: 0.4
            visible: _checkBox.checked
        }

        Text {
            x: 10
            id: _dateText
            font.pointSize: 10
            visible: _checkBox.checked
        }
    }

    CheckBox {
        id: _checkBox
        checked: false
        checkable: true
        anchors.right: parent.right
        anchors.top: parent.top
        indicator.width: 20
        indicator.height: 20
        anchors.topMargin: 6
        onCheckedChanged: root.checkedChanged( checked )
    }

    Image {
        id: _editButton
        source: "qrc:/img/res/edit_icon.png"
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 10
        width: 16
        height: 16
        scale: mouseArea.containsMouse ? 1.1 : 1.0
        visible: _checkBox.checked

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: root.editClicked()
            hoverEnabled: true
        }
    }

    onMountainIdChanged: root.update()

    PropertyAnimation {
        id: _xAnimation
        property: "x"
        duration: 250
        easing.type: Easing.OutCubic
        to: root.isOpened ? parent.width - root.width - root.anchors.margins : parent.width;
        target: root
        onStarted: {
            root.anchors.left = undefined
            root.anchors.right = undefined
        }
        onStopped: {
            if ( root.isOpened )
                root.anchors.right = root.parent.right
            else
               root.anchors.left = root.parent.right
        }
    }

    Behavior on height {
        PropertyAnimation { duration: 200 }
    }
}
