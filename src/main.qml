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
        handle: SplitViewHandle{}
        hoverEnabled: false

        ListView
        {
            id: list

            spacing: 0
            anchors.margins: 2
            model: mountainsSortModel

            delegate: ListDelegate{}
            ScrollBar.vertical: ScrollBar {
               Component.onCompleted: x = -list.anchors.margins
            }
            currentIndex: -1
            highlightMoveDuration: 300
            onCurrentIndexChanged: {
                Managers.ViewManager.selectMountainById( currentIndex )
            }

            SplitView.minimumWidth: 160
            SplitView.maximumWidth: 160
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
