#pragma once

#include <QObject>
#include <QPoint>

class Cursor
	: public QObject
{
	Q_OBJECT

public:
	explicit Cursor( QObject * _parent = nullptr );

	Q_INVOKABLE QPoint getPos() const;
};

