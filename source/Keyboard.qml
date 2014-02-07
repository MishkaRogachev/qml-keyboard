import QtQuick 2.0

Rectangle {
    id: root
    // TODO: inherit keyboardItem instead of agregation

    property alias source: keyboardItem.source
    property alias keyWidth: keyboardItem.keyWidth
    property alias keyHeight: keyboardItem.keyHeight
    property alias bounds: keyboardItem.bounds
    property alias font: keyboardItem.font
    property alias fontColor: keyboardItem.fontColor
    property alias keyColor: keyboardItem.keyColor
    property alias keyPressedColor: keyboardItem.keyPressedColor

    color: "#192430"
    width: 1024
    height: 640

    KeyboardItem {
        id: keyboardItem
        anchors.centerIn: parent
        source: "keyboard_us.xml"

        onKeyClicked: console.log(key)
        onSwitchSource: root.source = source
    }
}

