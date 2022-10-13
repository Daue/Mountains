#pragma once

#include <QObject>

class MountainRole
		: public QObject
{
	Q_OBJECT

public:
	enum Type
	{
		  Id = Qt::UserRole
		, Name = Qt::UserRole + 1
		, Range = Qt::UserRole + 2
		, Height = Qt::UserRole + 3
		, Position = Qt::UserRole + 4
	};
	Q_ENUM( Type )
};

