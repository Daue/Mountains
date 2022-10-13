#include "src/mountains_model.hpp"
#include "src/mountain_role.hpp"

MountainsModel::MountainsModel( QObject* _parent )
	: QAbstractListModel( _parent )
{
	auto add
		= [ this ](
			  QString const& _name
			, QString const& _range
			, int _height
			, QPointF const& _position
			)
		{
			Mountain mountain;
			mountain.m_id = m_mountains.size();
			mountain.m_name = _name;
			mountain.m_range = _range;
			mountain.m_height = _height;
			mountain.m_mapPosition = _position;

			m_mountains.push_back( mountain );
		};

	add( "Rysy", "Tatry", 2499, QPointF( 49.17957166566931, 20.08810990531623 ) );
	add( "Babia Góra", "Beskid Żywiecki", 1725, QPointF( 49.573021043950206, 19.52932991735267 ) );
	add( "Śnieżka", "Karkonosze", 1602, QPointF( 50.73594285318304, 15.739781388817846 ) );
	add( "Śnieżnik", "Masyw Śnieżnika", 1425, QPointF( 50.207405130034765, 16.847424756277604 ) );
	add( "Tarnica", "Bieszczady", 1346, QPointF( 49.07477033353776, 22.7263211085218 ) );
	add( "Turbacz", "Gorce", 1310, QPointF( 49.54282046569494, 20.111387520419697 ) );
}

int
MountainsModel::rowCount( QModelIndex const& _parent ) const
{
	Q_UNUSED( _parent )

	return m_mountains.size();
}

QVariant
MountainsModel::data( QModelIndex const& _index, int _role ) const
{
	int row = _index.row();

	if ( row < 0 || row >= m_mountains.size() )
		return QVariant();

	Mountain const& mountain = m_mountains.at( row );

	switch( _role )
	{
		case MountainRole::Id:
			return mountain.m_id;
		case MountainRole::Name:
			return mountain.m_name;
		case MountainRole::Range:
			return mountain.m_range;
		case MountainRole::Height:
			return mountain.m_height;
		case MountainRole::Position:
			return mountain.m_mapPosition;
	}

	return QVariant();
}


QHash< int, QByteArray >
MountainsModel::roleNames() const
{
	static QHash< int, QByteArray > roleNames = {
			  { MountainRole::Id, "id" }
			, { MountainRole::Name, "name" }
			, { MountainRole::Range, "range" }
			, { MountainRole::Height, "height" }
			, { MountainRole::Position, "position" }
		};

	return roleNames;
}

QVariant
MountainsModel::getMountainById( int _id )
{
	QVariant variant;
	variant.setValue( m_mountains[ _id ] );

	return variant;
}
