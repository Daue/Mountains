#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "src/mountains_model.hpp"
#include "src/mountain_role.hpp"

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

	engine.load( QStringLiteral( "qrc:/src/main.qml" ) );

	return app.exec();
}
