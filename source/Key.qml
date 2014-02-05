import QtQuick 2.0

Item {
    id: root

    property alias text: textItem.text

    Rectangle {
        id: background
        color: "#FEFEFE"
        anchors.fill: parent
        anchors.margins: 2
    }

    Text {
        id: textItem
        anchors.centerIn: parent
        font.pixelSize: 35
    }
}
