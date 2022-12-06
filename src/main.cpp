#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "src/mountains_model.hpp"
#include "src/mountain_role.hpp"
#include "src/cursor.hpp"

int main(int argc, char *argv[])
{

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
	QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
	QGuiApplication app(argc, argv);

	QQmlApplicationEngine engine;

	qmlRegisterType< MountainRole >("mountains", 1, 0, "MountainRole" );

	MountainsModel mountainsModel;
	engine.rootContext()->setContextProperty( "mountainsModel", &mountainsModel );

	QSortFilterProxyModel mountainsSortModel;
	mountainsSortModel.setSourceModel( &mountainsModel );
	mountainsSortModel.setDynamicSortFilter( true );
	mountainsSortModel.setSortRole( MountainRole::Type::Id );
	mountainsSortModel.sort( 0 );
	engine.rootContext()->setContextProperty( "mountainsSortModel", &mountainsSortModel );

	Cursor cursor;
	engine.rootContext()->setContextProperty( "cursor", &cursor );

	engine.load( QStringLiteral( "qrc:/src/main.qml" ) );

	return app.exec();
}
