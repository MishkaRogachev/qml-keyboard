import QtQuick 2.0

Item {
    id: root

    property alias text: textItem.text
    property alias font: textItem.font
    property alias iconSource: icon.source

    Rectangle {
        id: background
        color: "#FEFEFE"
        anchors.fill: parent
        anchors.margins: 2
    }

    Row {
        anchors.centerIn: parent

        Image {
            id: icon
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: textItem
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
