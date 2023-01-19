var ViewManager = {};

ViewManager._construct = function( _map, _list, _infoPopup ) {
    this.map = _map;
    this.list = _list;
    this.infoPopup = _infoPopup;
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

    if ( SettingsManager.isMountainEnabled( _mountainId ) )
        this.infoPopup.open()
    else
        this.infoPopup.close()
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

SettingsManager.isMountainEnabled = function( _mountainId ) {
    return settings.getMountainUserData( _mountainId ).enabled;
}

SettingsManager.setMountainEnabled = function( _mountainId, _enabled ) {
    var userData = settings.getMountainUserData( _mountainId );
    userData.enabled = _enabled
    settings.setMountainUserData( _mountainId, userData )
}
