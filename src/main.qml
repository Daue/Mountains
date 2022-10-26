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

        Rectangle
        {
            SplitView.preferredWidth: 100
            color: "red"
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
