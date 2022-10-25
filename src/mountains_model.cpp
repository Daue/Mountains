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

	//sprawdz jescze raz wysokosci wszystkic szczytow, z ksiazeczki i internetu !!!!

	add( "Rysy", "Tatry", 2499, QPointF( 49.17957166566931, 20.08810990531623 ) );
	add( "Babia Góra", "Beskid Żywiecki", 1725, QPointF( 49.573021043950206, 19.52932991735267 ) );
	add( "Śnieżka", "Karkonosze", 1602, QPointF( 50.73594285318304, 15.739781388817846 ) );
	add( "Śnieżnik", "Masyw Śnieżnika", 1425, QPointF( 50.207405130034765, 16.847424756277604 ) );
	add( "Tarnica", "Bieszczady", 1346, QPointF( 49.07477033353776, 22.7263211085218 ) );
	add( "Turbacz", "Gorce", 1310, QPointF( 49.54282046569494, 20.111387520419697 ) );
	add( "Radziejowa", "Beskid Sądecki", 1262, QPointF( 49.44930236567149, 20.60411998729188 ) );
	add( "Skrzyczne", "Beskid Śląski", 1257, QPointF( 49.68457372268671, 19.03027417553065 ) );
	add( "Mogielica", "Beskid Wyspowy", 1170, QPointF( 49.655320270343466, 20.276677187363447 ) );
	add( "Wysoka Kopa", "Góry Izerskie", 1126, QPointF( 50.84999924537459, 15.420279309591223 ) );
	add( "Rudawiec", "Góry Bialskie", 1112, QPointF( 50.244803687538585, 16.976860792705338 ) );
	add( "Orlica", "Góry Orlickie", 1084, QPointF( 50.353249718091305, 16.360628613667473 ) );
	add( "Wysoka", "Pieniny", 1050, QPointF( 49.38026085693358, 20.55549967152868 ) );
	add( "Wielka Sowa", "Góry Sowie", 1015, QPointF( 50.68027699271707, 16.485556634387535 ) ); //blad na strontie korony.info
	add( "Lackowa", "Beskid Niski", 997, QPointF( 49.4264825302071, 21.102470014422323 ) );
	add( "Kowadło", "Góry Złote", 989, QPointF( 50.26442716084085, 17.013219883462455 ) );
	add( "Jagodna", "Góry Bystrzyckie", 977, QPointF( 50.252456305922536, 16.56441859073834 ) );
	add( "Skalnik", "Rudawy Janowickie", 945, QPointF( 50.80847811912257, 15.90005786067809 ) );
	add( "Waligóra", "Góry Kamienne", 936, QPointF( 50.68082553190651, 16.278090958230962 ) );
	add( "Czupel", "Beskid Mały", 934, QPointF( 49.7678796584515, 19.161027885583394 ) );
	add( "Szczeliniec Wielki", "Góry Stołowe", 919, QPointF( 50.48481299047023, 16.341005512819663 ) );
	add( "Lubomir", "Beskid Makowski", 912, QPointF( 49.766976569582674, 20.05969280030132 ) );
	add( "Biskupia Kopa", "Góry Opawskie", 889, QPointF( 50.25670425476174, 17.42859807349089 ) );
	add( "Chełmiec", "Góry Wałbrzyskie", 869, QPointF( 50.77954366856348, 16.210977664526126 ) );
	add( "Kłodzka Góra", "Góry Bardzkie", 757, QPointF( 50.45166897225994, 16.753220590584277 ) );
	add( "Skopiec", "Góry Kaczawskie", 724, QPointF( 50.94392885397913, 15.884709374302446 ) );
	add( "Ślęża", "Masyw Ślęży", 718, QPointF( 50.864087656338135, 16.70749512412172 ) );
	add( "Łysica", "Góry Świętokrzyskie", 612, QPointF( 50.891615685012155, 20.896594614342803 ) );
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
