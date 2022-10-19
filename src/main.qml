import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    width: 1200
    height: 800
    visible: true
    title: qsTr("Korona Gór Polski")

    MapView{
        id: map
        anchors.fill: parent
        zoomLevel: 7
        model: mountainsModel

        onSelectedMountainIdChanged: {
            console.log( map.selectedMountainId )
            console.log( mountainsModel.getMountainById( map.selectedMountainId ) )
        }

        onHoverStart: (id) => {
            var mountain = mountainsModel.getMountainById( id );
            popup.text = mountain.name + " " + mountain.height + " m n.p.m. (" + mountain.range + ")"
            popup.opacity = 1.0;
        }

        onHover: (id) => {
           var mousePos = cursor.getPos();
           mousePos = map.mapFromGlobal( mousePos.x, mousePos.y );
           popup.x = mousePos.x + 10
           popup.y = mousePos.y - popup.height - 10
        }

        onHoverEnd: (id) => {
            popup.opacity = 0;
        }

        Component.onCompleted: {
            map.fitViewportToVisibleMapItems();
        }
    }

    Popup {
        id: popup
    }
}
