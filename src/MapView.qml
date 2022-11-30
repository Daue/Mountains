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

    Repeater {
        id: repeater

        delegate: MapQuickItem {

            id: item
            anchorPoint.x: sourceItem.width/2
            anchorPoint.y: sourceItem.height
            coordinate: QtPositioning.coordinate( model.position.x, model.position.y )
            z: model.position.y

            sourceItem: Image {
                source: "qrc:/img/res/mountain_pin.png"
                antialiasing: true
                sourceSize.width: 20
                sourceSize.height: 40
            }

            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    selectedMountainId = model.id;
                }
                onEntered:
                {
                    var mountain = mountainsModel.getMountainById( id );

                    popup.title = mountain.name + " (" + mountain.height + " m n.p.m.)"
                    popup.description = mountain.range
                    popup.show()

                    item.scale = 1.3
                    map.hoverStart( model.id );
                }

                onPositionChanged:
                {
                    var mousePos = cursor.getPos();
                    mousePos = map.mapFromGlobal( mousePos.x, mousePos.y );
                    popup.x = mousePos.x + 10
                    popup.y = mousePos.y - popup.height - 10

                    map.hover( model.id );
                }

                onExited:
                {
                    popup.hide()
                    item.scale = 1
                    map.hoverEnd( model.id );
                }
            }
        }
    }

    MapPopup {
        id: popup
        z: 1000
    }

    onMapReadyChanged: {
         map.fitViewportToVisibleMapItems();
    }
}
