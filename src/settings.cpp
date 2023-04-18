#include "settings.hpp"

#include <QDebug>
#include <QStandardPaths>
#include <QXmlStreamWriter>
#include <QXmlStreamReader>

#include <QDebug>

Settings::Settings(QObject* _parent)
	: QObject{ _parent }
{
	load();
}

Settings::~Settings()
{
	save();
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
	QFile file( "settings.xml" );
	file.open( QIODevice::WriteOnly | QIODevice::Truncate );

	QXmlStreamWriter writer( &file );
	writer.setAutoFormatting( true );

	writer.writeStartDocument();
	writer.writeStartElement("root");

	//write mountains
	for ( auto it = m_mountainsUserData.begin(); it != m_mountainsUserData.end(); ++it )
	{
		if ( !it.value().m_checked )
			continue;

		writer.writeStartElement("mountain");
		writer.writeAttribute("id", QString::number( it.key() ));

		if ( it.value().m_date.isValid() )
			writer.writeAttribute("date", it.value().m_date.toString("dd-MM-yyyy"));

		writer.writeEndElement();
	}

	writer.writeEndElement();
	writer.writeEndDocument();

	file.close();
}

void
Settings::load()
{
	QFile file( "settings.xml" );
	if ( !file.open( QIODevice::ReadOnly ) )
		return;

	QXmlStreamReader reader( &file );

	//read root
	if ( !reader.readNextStartElement() )
		return;

	//read mountains
	while ( reader.readNextStartElement() )
	{
		int id = reader.attributes().value( "id").toInt();

		MountainUserData data;
		data.m_checked = true;
		if ( reader.attributes().hasAttribute("date") )
			data.m_date = QDate::fromString( reader.attributes().value( "date" ).toString(), "dd-MM-yyyy" );

		setMountainUserData( id, data );

		reader.skipCurrentElement();
	}

}
