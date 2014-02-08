import QtQuick 2.0

Item {
    id: root

    property alias mainLabel: mainLabelItem.text
    property alias secondaryLabels: secondaryLabelsItem.text
    property alias iconSource: icon.source

    property bool isChekable: false
    property bool isChecked: false

    property int bounds: 2

    property alias mainFont: mainLabelItem.font
    property alias secondaryFont: secondaryLabelsItem.font
    property alias mainFontColor: mainLabelItem.color
    property alias secondaryFontColor: secondaryLabelsItem.color

    property color keyColor: "gray"
    property color keyPressedColor: "white"

    signal clicked()
    signal alternatesClicked(string symbol)

    Rectangle {
        id: backgroundItem
        anchors.fill: parent
        anchors.margins: root.bounds
        color: isChecked || mouseArea.pressed ? keyPressedColor : keyColor;
    }

    Column
    {
        anchors.centerIn: backgroundItem

        Text {
            id: secondaryLabelsItem
            smooth: true
            anchors.right: parent.right
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter

            Image {
                id: icon
                smooth: true
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                id: mainLabelItem
                smooth: true
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    Row {
        id: alternatesRow
        property int selectedIndex: -1
        visible: false
        anchors.bottom: backgroundItem.top
        anchors.left: backgroundItem.left

        Repeater {
            model: secondaryLabels.length

            Rectangle {
                property bool isSelected: alternatesRow.selectedIndex == index
                color: isSelected ? mainLabelItem.color : keyPressedColor
                height: backgroundItem.height
                width: backgroundItem.width

                Text {
                    anchors.centerIn: parent
                    text: secondaryLabels[ index ]
                    font: mainLabelItem.font
                    color: isSelected ? keyPressedColor : mainLabelItem.color
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
                root.alternatesClicked(secondaryLabels[alternatesRow.selectedIndex])
        }

        onMouseXChanged: {
            alternatesRow.selectedIndex =
            (mouseY < 0 && mouseX > 0 && mouseY < alternatesRow.width) ?
                        Math.floor(mouseX / backgroundItem.width) :
                        -1;
        }
    }
}
