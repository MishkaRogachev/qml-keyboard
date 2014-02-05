import QtQuick 2.0
import QtQuick.XmlListModel 2.0

Rectangle {
    id: root

    property url source: "mobile-keyboard.xml"
    property string currentMode: ""
    property int keyWidth: 75
    property int keyHeight: 100

    color: "#2C3E50"
    width: 1024
    height: 640

    Repeater {
        id: keyboardModeRepeater

        model: XmlListModel {
            source: root.source
            query: "/Keyboard/Mode"

            XmlRole { name: "mode"; query: "@id/string()" }
        }

        KeyboardItem {
            id: keyboardItem
            anchors.centerIn: parent
            source: root.source
            Component.onCompleted: if (index === 0) currentMode=mode;
            visible: mode === currentMode
            keyWidth: root.keyWidth
            keyHeight: root.keyHeight
        }
    }
}

