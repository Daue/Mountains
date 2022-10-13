#pragma once

#include <QAbstractListModel>
#include <QVector>

#include "src/mountain.hpp"

class MountainsModel
		: public QAbstractListModel
{
	Q_OBJECT

public:
	MountainsModel( QObject* _parent = nullptr );

	int rowCount( QModelIndex const& _parent ) const override;
	QVariant data( QModelIndex const& _index, int _role) const override;
	QHash< int, QByteArray > roleNames() const override;

	Q_INVOKABLE QVariant getMountainById( int _id );

private:
	QVector< Mountain > m_mountains;
};

