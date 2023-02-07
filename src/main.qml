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

        ListView
        {
            id: list

            spacing: 2
            anchors.margins: 2
            model: mountainsSortModel

            delegate: ListDelegate{
                checkBox.checked: Managers.SettingsManager.isMountainChecked( model.id )
                checkBox.onCheckedChanged: {
                    Managers.SettingsManager.setMountainChecked( model.id, checkBox.checked );
                    Managers.ViewManager.selectMountainById( model.id );
                }
            }
            ScrollBar.vertical: ScrollBar {
               Component.onCompleted: x = -list.anchors.margins
            }
            currentIndex: -1
            highlightMoveDuration: 300
            onCurrentIndexChanged: Managers.ViewManager.selectMountainById( currentIndex )

            SplitView.preferredWidth: 200
        }

        MapView{
            id: map
            zoomLevel: 7
            model: mountainsModel
            onSelectedMountainIdChanged: Managers.ViewManager.selectMountainById( map.selectedMountainId );

            onHoverStart: (id) => {
            }

            onHover: (id) => {
            }

            onHoverEnd: (id) => {
            }

            SplitView.fillWidth: true
        }
    }

    InfoPopup{
        id: infoPopup
        onEditClicked: console.log( "EDIT ")
    }

    Component.onCompleted: {
        Managers.ViewManager._construct(map, list, infoPopup );
    }
}
