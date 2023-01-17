#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "src/mountains_model.hpp"
#include "src/mountain_role.hpp"
#include "src/mountain_user_data.hpp"
#include "src/cursor.hpp"
#include "src/settings.hpp"

int main(int argc, char *argv[])
{

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
	QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
	QGuiApplication app(argc, argv);
	QQmlApplicationEngine engine;

	Cursor cursor;
	Settings settings;

	MountainsModel mountainsModel;
	QSortFilterProxyModel mountainsSortModel;
	mountainsSortModel.setSourceModel( &mountainsModel );
	mountainsSortModel.setDynamicSortFilter( true );
	mountainsSortModel.setSortRole( MountainRole::Type::Id );
	mountainsSortModel.sort( 0 );

	qmlRegisterType< MountainRole >("mountains", 1, 0, "MountainRole" );
	engine.rootContext()->setContextProperty( "mountainsModel", &mountainsModel );
	engine.rootContext()->setContextProperty( "mountainsSortModel", &mountainsSortModel );
	engine.rootContext()->setContextProperty( "cursor", &cursor );
	engine.rootContext()->setContextProperty( "settings", &settings );

	engine.load( QStringLiteral( "qrc:/src/main.qml" ) );

	return app.exec();
}
