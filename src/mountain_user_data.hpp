#pragma once

#include <QtCore>
#include <QDate>

struct MountainUserData
{
	Q_GADGET
	Q_PROPERTY( bool enabled MEMBER m_enabled )
	Q_PROPERTY( QDate date MEMBER m_date )
	//.... in progress (description, fotos)

public:
	bool m_enabled = false;
	QDate m_date;
};

Q_DECLARE_METATYPE(MountainUserData)
