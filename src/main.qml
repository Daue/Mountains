import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import mountains 1.0

import "managers.js" as Managers

Window {
    width: 1200
    height: 800
    visible: true
    title: qsTr("Korona Gór Polski")

    SplitView{
        anchors.fill: parent
        orientation: Qt.Horizontal
        hoverEnabled: false
        handle: Rectangle { implicitWidth: 2; color: "lightgrey" }

        ListView
        {
            id: list

            spacing: 2
            anchors.margins: 2
            model: mountainsSortModel

            delegate: ListDelegate{
                width: ListView.view.width - 10
                height: 58
                anchors.horizontalCenter: parent ? parent.horizontalCenter : undefined
            }
            ScrollBar.vertical: ScrollBar {
               Component.onCompleted: x = -list.anchors.margins
            }
            currentIndex: -1
            highlightMoveDuration: 300
            onCurrentIndexChanged: {
                Managers.ViewManager.selectMountainById( currentIndex )
            }

             SplitView.minimumWidth: 180
             SplitView.maximumWidth: 180
        }

        MapView{
            id: map
            zoomLevel: 7
            model: mountainsModel
            onSelectedMountainIdChanged: Managers.ViewManager.selectMountainById( map.selectedMountainId );

            SplitView.fillWidth: true
        }
    }

    InfoPopup{
        id: mountainInfo
        onEditClicked: Managers.ViewManager.openDatePickerDialog()
        onCheckedChanged: function( _checked ) {
            if ( Managers.SettingsManager.isMountainChecked( map.selectedMountainId ) === _checked )
                return;
            Managers.SettingsManager.setMountainChecked( map.selectedMountainId, _checked );
            Managers.ViewManager.selectMountainById( map.selectedMountainId );
        }
    }

    Component.onCompleted: {
        Managers.ViewManager._construct(map, list, mountainInfo );
    }
}
