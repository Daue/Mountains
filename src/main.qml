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
        handle: SplitViewHandle{}

        ListView
        {
            id: list
            SplitView.preferredWidth: 150

            spacing: 2
            anchors.margins: 2
            model: mountainsSortModel
            delegate: ListDelegate{}
            ScrollBar.vertical: ScrollBar {}
            currentIndex: -1
        }

        MapView{
            SplitView.fillWidth: true

            id: map
            zoomLevel: 7
            model: mountainsModel

            onSelectedMountainIdChanged: {
                //console.log( map.selectedMountainId )
                //console.log( mountainsModel.getMountainById( map.selectedMountainId ) )
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
