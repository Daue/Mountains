import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    width: 1200
    height: 800
    visible: true
    title: qsTr("Korona Gór Polski")

    SplitView
    {
        anchors.fill: parent
        orientation: Qt.Horizontal

        handle: Rectangle {
               id: handleDelegate
               implicitWidth: 4
               implicitHeight: 4
               color: SplitHandle.hovered ? Qt.lighter("darkseagreen", 1.1 ) : "darkseagreen"

               containmentMask: Item {
                   x: (handleDelegate.width - width) / 2
                   width: 64
                   height: splitView.height
               }
           }

        MountainsListView
        {
            SplitView.preferredWidth: 150
            model: mountainsSortModel
        }

        MapView{
            SplitView.fillWidth: true

            id: map
            zoomLevel: 7
            model: mountainsModel

            onSelectedMountainIdChanged: {
                console.log( map.selectedMountainId )
                console.log( mountainsModel.getMountainById( map.selectedMountainId ) )
            }

            onHoverStart: (id) => {
            }

            onHover: (id) => {
            }

            onHoverEnd: (id) => {
            }
        }
    }

}
