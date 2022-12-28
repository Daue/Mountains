import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import mountains 1.0

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
            highlightMoveDuration: 300

            function findIndexByMountainId( _id )
            {
                if ( !model )
                    return -1;

                for ( var i = 0; i < model.rowCount(); ++i )
                {
                    var mountainId = model.data( model.index(i,0), MountainRole.Id );
                    if ( mountainId === _id )
                        return i;
                }

                return -1;
            }

            onCurrentIndexChanged: {
                if ( currentIndex == -1 )
                {
                    map.selectedMountainId = -1;
                    return;
                }

                map.selectedMountainId = model.data( model.index( currentIndex,0), MountainRole.Id );
                map.fitToMountain( map.selectedMountainId );
            }
        }

        MapView{
            SplitView.fillWidth: true

            id: map
            zoomLevel: 7
            model: mountainsModel

            onSelectedMountainIdChanged: {
               list.currentIndex = list.findIndexByMountainId( map.selectedMountainId )
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
