import QtQuick 2.0
import QtLocation 5.15
import QtPositioning 5.15

import "managers.js" as Managers

Map {
    id: map

    property alias model : repeater.model
    property int selectedMountainId: -1

    function checkMountain( _mountainId, _checked ) {
        for ( var i=0; i<mapItems.length; ++i)
        {
            var item = mapItems[i];
            if ( item.mountainId === _mountainId )
            {
                item.mountainChecked = _checked;
                break;
            }
        }
    }

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
            property int mountainId: model.id
            property bool mountainChecked: Managers.SettingsManager.isMountainChecked( model.id )

            anchorPoint.x: sourceItem.width/2
            anchorPoint.y: sourceItem.height
            coordinate: QtPositioning.coordinate( model.position.x, model.position.y )
            z: ( selectedMountainId === model.id ) ? 100 : model.position.y
            scale: ( mouseArea.containsMouse || selectedMountainId === model.id ) ? 1.3 : 1
            opacity: map.zoomLevel > 14 ? 0.4 : 1

            sourceItem: Image {
                id: _image
                source: mountainChecked ? "qrc:/img/res/mountain_pin_checked.png" : "qrc:/img/res/mountain_pin_unchecked.png"
                antialiasing: true
                sourceSize.width: 20
                sourceSize.height: 40

                Rectangle {
                    id: glow
                    width: 14
                    height: width
                    color: "white"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -6
                    radius: width/2
                    opacity: 0.8
                    visible: selectedMountainId === item.mountainId
                    border.width: 1
                    border.color: mountainChecked ? "black" : "black"
                }
            }

            MouseArea{
                id: mouseArea
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
                }

                onPositionChanged:
                {
                    var mousePos = cursor.getPos();
                    mousePos = map.mapFromGlobal( mousePos.x, mousePos.y );

                    var popupOffset = 10;

                    popup.x
                        = mousePos.x + popupOffset + popup.width < map.widt
                        ? mousePos.x + popupOffset
                        : mousePos.x - popup.width - popupOffset;

                    popup.y = mousePos.y - popup.height - popupOffset;
                }

                onExited:
                {
                    popup.hide()
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: selectedMountainId = -1
    }

    MapPopup {
        id: popup
        z: 1000
    }

    onMapReadyChanged: {
         map.fitViewportToVisibleMapItems();
    }
}
