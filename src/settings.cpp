#include "settings.hpp"

#include <QDebug>
#include <QSettings>
#include <QStandardPaths>

namespace
{
	const QString SettingsFileName = "settings.ini";
}

Settings::Settings(QObject* _parent)
	: QObject{ _parent }
{
	save();
	load();
}

void
Settings::setMountainUserData( int _mountainId, MountainUserData _data )
{
	m_mountainsUserData[ _mountainId ] = _data;
}

QVariant
Settings::getMountainUserData(int _mountainId)
{
	MountainUserData data;

	if ( m_mountainsUserData.contains( _mountainId ) )
		data = m_mountainsUserData[ _mountainId ];

	QVariant variant;
	variant.setValue( data );

	return variant;
}

void
Settings::save()
{
	QSettings settings( SettingsFileName, QSettings::IniFormat );
}

void
Settings::load()
{
	QSettings settings( SettingsFileName, QSettings::IniFormat );
}
