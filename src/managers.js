var ViewManager = {};

ViewManager._construct = function( _map, _list, _infoPopup ) {
    this.map = _map;
    this.list = _list;
    this.infoPopup = _infoPopup;
    this.datePickerDialog = null
}

ViewManager.selectMountainById = function( _mountainId )
{
    if ( _mountainId === -1 )
    {
        this.map.selectedMountainId = -1;
        this.list.currentIndex = -1;
        this.infoPopup.close();

        return;
    }

    if ( this.map.selectedMountainId !== _mountainId )
        this.map.selectedMountainId = _mountainId;

    var listIndex = findIndexByMountainId( this.list, _mountainId )
    if ( this.list.currentIndex !== listIndex )
        this.list.currentIndex = listIndex;

    this.infoPopup.open( _mountainId )
}

ViewManager.onMountainChecked = function( _mountainId, _checked ) {
    this.map.checkMountain(_mountainId,_checked);

    var listIndex = findIndexByMountainId( this.list, _mountainId )
    var item = this.list.itemAtIndex( listIndex)
    item.flagVisible = _checked
}

ViewManager.onMountainDateChanged = function( _mountainId ) {
    this.infoPopup.update()
}

ViewManager.openDatePickerDialog = function() {
    var component = Qt.createComponent( "DatePicker.qml")
    this.datePickerDialog = component.createObject( this.map.parent )

    if ( this.map.selectedMountainId !== -1 )
    {
        var userData = settings.getMountainUserData( this.map.selectedMountainId );
        if ( userData.date.toLocaleTimeString() !== "" )
            this.datePickerDialog.selectedDate = userData.date
        else
            this.datePickerDialog.selectedDate = new Date()
    }

    this.datePickerDialog.anchors.centerIn = this.map.parent
    this.datePickerDialog.open()
    this.datePickerDialog.accepted.connect( () => {
             SettingsManager.setMountainDate( this.map.selectedMountainId, this.datePickerDialog.selectedDate )
         } );
}

function findIndexByMountainId( _list, _mountainId ) {
    if ( !_list.model || _mountainId === -1 )
        return -1;

     for ( var i = 0; i < _list.model.rowCount(); ++i )
     {
         var mountainId = _list.model.data( _list.model.index(i,0), MountainRole.Id );
         if ( mountainId === _mountainId )
             return i;
     }

     return -1;
}

var SettingsManager = {}

SettingsManager.isMountainChecked = function( _mountainId ) {
    return settings.getMountainUserData( _mountainId ).checked;
}

SettingsManager.setMountainChecked = function( _mountainId, _checked ) {
    var userData = settings.getMountainUserData( _mountainId );
    userData.checked = _checked
    settings.setMountainUserData( _mountainId, userData )
    ViewManager.onMountainChecked(_mountainId,_checked);
}

SettingsManager.getMountainDate = function( _mountainId ) {
    return settings.getMountainUserData( _mountainId ).date;
}

SettingsManager.setMountainDate = function( _mountainId, date ) {
    var userData = settings.getMountainUserData( _mountainId );
    userData.date = date
    settings.setMountainUserData( _mountainId, userData )
    ViewManager.onMountainDateChanged( _mountainId )
}
