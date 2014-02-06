import QtQuick 2.0
import QtQuick.XmlListModel 2.0

Rectangle {
    id: root

    property url source: "keyboard_us.xml"
    property int keyWidth: 75
    property int keyHeight: 100
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
        source: root.source

        onKeyClicked: console.log(key)
        onSwitchSource: root.source = source
    }
}

