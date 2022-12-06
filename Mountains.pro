QT += quick

HEADERS += \
	src/cursor.hpp \
	src/mountain.hpp \
	src/mountain_role.hpp \
	src/mountains_model.hpp

SOURCES += \
	src/cursor.cpp \
	src/main.cpp \
	src/mountains_model.cpp

RESOURCES += \
	Mountains.qrc

DISTFILES += \
	src/main.qml
	src/MapView.qml
	src/MapPopup.qml
	src/MountainsListView.qml

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target


