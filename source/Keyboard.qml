import QtQuick 2.0
import QtQuick.XmlListModel 2.0

Rectangle {
    id: root

    property url source: "mobile-keyboard.xml"
    property string currentMode: ""

    color: "#2C3E50"
    width: 740
    height: 320

    Repeater {
        id: keyboardModeRepeater

        model: XmlListModel {
            source: root.source
            query: "/Keyboard/Mode"

            XmlRole { name: "mode"; query: "@id/string()" }
        }

        KeyboardItem {
            id: keyboardItem
            anchors.fill: root
            source: root.source
            Component.onCompleted: if (index === 0) currentMode=mode;
            visible: mode === currentMode
        }
    }
}

