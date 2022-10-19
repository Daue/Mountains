#include "cursor.hpp"
#include <QCursor>

Cursor::Cursor( QObject * _parent )
	: QObject( _parent )
{
}

QPoint
Cursor::getPos() const
{
	QCursor cursor;
	return cursor.pos();
}
