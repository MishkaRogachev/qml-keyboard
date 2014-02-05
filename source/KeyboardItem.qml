import QtQuick 2.0
import QtQuick.XmlListModel 2.0

Item {
    id: root

    property string source: ""
    property string mode: ""
    property int keyWidth: 50
    property int keyHeight: 50
    property alias font: proxyTextItem.font

    Text { id: proxyTextItem }

    Column {
        id: column
        anchors.centerIn: parent

        Repeater {
            id: rowRepeater
            model: XmlListModel {
                source: root.source
                query: "/Keyboard/" + mode + "/Row"
            }

            Row {
                id: keyRow
                anchors.horizontalCenter: parent.horizontalCenter

                Repeater {
                    id: keyRepeater
                    model: XmlListModel {
                        source: root.source
                        query: "/Keyboard/" + mode + "/Row[" +
                               (index + 1) + "]/Key"

                        XmlRole { name: "labels"; query: "@labels/string()" }
                        XmlRole { name: "ratio"; query: "@ratio/number()" }
                        XmlRole { name: "icon"; query: "@icon/string()" }
                    }

                    Key {
                        width: keyWidth * ratio
                        height: keyHeight
                        text: labels.split(/[!|]+/)[0].toString();
                        font: proxyTextItem.font
                        iconSource: icon
                    }
                }
            }
        }
    }
}
