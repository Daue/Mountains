import QtQuick 2.0
import QtLocation 5.15
import QtPositioning 5.15

Map {
    id: map

    property alias model : repeater.model
    property int selectedMountainId: -1
    signal hoverStart( var _mountainId )
    signal hover( var _mountainId )
    signal hoverEnd( var _mountainId )

    plugin: Plugin {
        name: "osm"
        PluginParameter {
            name: "osm.mapping.providersrepository.disabled"
            value: "true"
        }
        PluginParameter {
            name: "osm.mapping.providersrepository.address"
            value: "http://maps-redirect.qt.io/osm/5.6/"
        }
    }

    //to remove
    MouseArea {
        anchors.fill: parent
        propagateComposedEvents: true
        //hoverEnabled: true
        onClicked: {
            selectedMountainId = -1
            var pos = map.toCoordinate( Qt.point( mouseX, mouseY ) )
            console.log( pos.latitude, pos.longitude )
        }
    }

    Repeater {
        id: repeater

        delegate: MapQuickItem {

            id: item
            anchorPoint.x: sourceItem.width/2
            anchorPoint.y: sourceItem.height
            coordinate: QtPositioning.coordinate( model.position.x, model.position.y )

            sourceItem: Image {
                source: "qrc:/img/res/mountain_pin.png"
                antialiasing: true
                sourceSize.width: 30
                sourceSize.height: 60
            }

            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    selectedMountainId = model.id;
                }
                onEntered:
                {
                    item.scale = 1.3
                    map.hoverStart( model.id );
                }

                onPositionChanged: {
                    map.hover( model.id );
                }

                onExited:
                {
                    item.scale = 1
                    map.hoverEnd( model.id );
                }
            }
        }
    }
}
