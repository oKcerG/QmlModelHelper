TEMPLATE = app
TARGET = tst_qmlmodelhelper
QT += qml quick
CONFIG += c++11 warn_on qmltestcase qml_debug no_keywords

include(../QmlModelHelper.pri)

SOURCES += \
    tst_qmlmodelhelper.cpp

OTHER_FILES += \
    tst_count.qml \
    tst_map.qml \
    tst_roles.qml
