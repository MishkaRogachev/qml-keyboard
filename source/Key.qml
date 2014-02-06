import QtQuick 2.0

Item {
    id: root

    property alias text: textItem.text
    property alias font: textItem.font
    property alias iconSource: icon.source
    property alias fontColor: textItem.color
    property color keyColor
    property color keyPressedColor

    signal clicked()

    Rectangle {
        id: backgroundItem
        anchors.fill: parent
        anchors.margins: 2
        color: mouseArea.pressed ? keyPressedColor : keyColor;
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

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: root.clicked()
    }
}
