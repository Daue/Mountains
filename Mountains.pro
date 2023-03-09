QT += quick

HEADERS += \
	src/cursor.hpp \
	src/mountain.hpp \
	src/mountain_role.hpp \
	src/mountain_user_data.hpp \
	src/mountains_model.hpp \
	src/settings.hpp

SOURCES += \
	src/cursor.cpp \
	src/main.cpp \
	src/mountains_model.cpp \
	src/settings.cpp

RESOURCES += \
	Mountains.qrc

win32:RC_ICONS += res/window_icon.ico


#DISTFILES += \
#	src/main.qml \
#	src/MapView.qml \
#	src/MapPopup.qml \
#	src/MountainsListView.qml \
#	src/SplitViewHandle.qml

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target


