#pragma once

#include <QString>
#include <QtCore>

struct Mountain
{
	Q_GADGET
	Q_PROPERTY( int id MEMBER m_id )
	Q_PROPERTY( QString name MEMBER m_name )
	Q_PROPERTY( QString range MEMBER m_range )
	Q_PROPERTY( int height MEMBER m_height )
	Q_PROPERTY( QPointF position MEMBER m_mapPosition )

public:
	int m_id;
	QString m_name;
	QString m_range;
	int m_height;
	QPointF m_mapPosition;
};

Q_DECLARE_METATYPE( Mountain )

