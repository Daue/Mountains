#pragma once

#include <QtCore>
#include <QDate>

struct MountainUserData
{
	Q_GADGET
	Q_PROPERTY( bool checked MEMBER m_checked )
	Q_PROPERTY( QDate date MEMBER m_date )
	//.... in progress (description, fotos)

public:
	bool m_checked = false;
	QDate m_date;
};

Q_DECLARE_METATYPE(MountainUserData)
