import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import mountains 1.0

import "view_manager.js" as Manager

Window {
    width: 1200
    height: 800
    visible: true
    title: qsTr("Korona Gór Polski")

    SplitView
    {
        anchors.fill: parent
        orientation: Qt.Horizontal
        handle: SplitViewHandle{}

        ListView
        {
            id: list

            function selectMountainById( _mountainId )
            {
                Manager.ViewManager.clear()
                if ( _mountainId === -1 )
                {
                    map.selectedMountainId = -1;
                    infoPopup.close()
                }
                else
                {
                    map.selectedMountainId = model.data( model.index( _mountainId,0), MountainRole.Id );
                    if ( settings.getMountainUserData( _mountainId ).enabled )
                        infoPopup.open()
                    else
                        infoPopup.close()
                }
            }

            SplitView.preferredWidth: 200

            spacing: 2
            anchors.margins: 2
            model: mountainsSortModel
            delegate: ListDelegate{
                checkBox.checked: settings.getMountainUserData( model.id ).enabled
                checkBox.onCheckedChanged: {
                    var userData = settings.getMountainUserData( model.id );
                    userData.enabled = checkBox.checked
                    settings.setMountainUserData( model.id, userData )
                    list.selectMountainById( model.id )
                }
            }
            ScrollBar.vertical: ScrollBar {
               Component.onCompleted: x = -list.anchors.margins
            }
            currentIndex: -1
            highlightMoveDuration: 300
            onCurrentIndexChanged: selectMountainById( currentIndex )
        }

        MapView{
            SplitView.fillWidth: true

            id: map
            zoomLevel: 7
            model: mountainsModel

            onSelectedMountainIdChanged: {
               if ( !list.model || map.selectedMountainId == -1 )
               {
                   list.currentIndex = -1;
                   return;
               }

                for ( var i = 0; i < list.model.rowCount(); ++i )
                {
                    var mountainId = list.model.data( list.model.index(i,0), MountainRole.Id );
                    if ( mountainId === map.selectedMountainId )
                    {
                        list.currentIndex = i;
                        break;
                    }
                }
            }

            onHoverStart: (id) => {
            }

            onHover: (id) => {
            }

            onHoverEnd: (id) => {
            }
        }
    }

    InfoPopup{ id: infoPopup }

    Component.onCompleted: {
        Manager.ViewManager._construct(map, list, infoPopup)
    }
}
