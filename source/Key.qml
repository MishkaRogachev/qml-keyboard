import QtQuick 2.0

Item {
    id: root

    property alias text: textItem.text
    property alias font: textItem.font
    property alias iconSource: icon.source
    property alias fontColor: textItem.color
    property int bounds: 0
    property color keyColor
    property color keyPressedColor
    property bool isChekable: false
    property bool isChecked: false

    property string alternates: ""

    signal clicked()
    signal alternatesClicked(string symbol)

    Rectangle {
        id: backgroundItem
        anchors.fill: parent
        anchors.margins: root.bounds
        color: isChecked || mouseArea.pressed ? keyPressedColor : keyColor;
    }

    Row {
        anchors.centerIn: parent

        Image {
            id: icon
            smooth: true
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: textItem
            smooth: true
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Row {
        id: alternatesRow
        property int selectedIndex: -1
        visible: false
        anchors.bottom: backgroundItem.top
        anchors.left: backgroundItem.left

        Repeater {
            model: alternates.length

            Rectangle {
                property bool isSelected: alternatesRow.selectedIndex == index
                color: isSelected ? textItem.color : keyPressedColor
                height: backgroundItem.height
                width: backgroundItem.width

                Text {
                    anchors.centerIn: parent
                    text: alternates[ index ]
                    font: textItem.font
                    color: isSelected ? keyPressedColor : textItem.color
                }
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onPressAndHold: alternatesRow.visible = true
        onClicked: {
            if (isChekable) isChecked = !isChecked
            root.clicked()
        }


        onReleased: {
            alternatesRow.visible = false
            if (alternatesRow.selectedIndex > -1)
                root.alternatesClicked(alternates[alternatesRow.selectedIndex])
        }

        onMouseXChanged: {
            alternatesRow.selectedIndex =
            (mouseY < 0 && mouseX > 0 && mouseY < alternatesRow.width) ?
                        Math.floor(mouseX / backgroundItem.width) :
                        -1;
        }
    }
}
