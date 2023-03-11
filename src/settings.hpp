#pragma once

#include <QObject>
#include <QHash>
#include <QVariant>

#include "src/mountain_user_data.hpp"

class Settings : public QObject
{
	Q_OBJECT

public:
	explicit Settings( QObject* _parent = nullptr);
	~Settings();

	Q_INVOKABLE void setMountainUserData( int _mountainId, MountainUserData _data );
	Q_INVOKABLE QVariant getMountainUserData( int _mountainId );

private:
	void save();
	void load();

private:
	QHash< int, MountainUserData > m_mountainsUserData;
};

