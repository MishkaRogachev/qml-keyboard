import QtQuick 2.0
import QtQuick.XmlListModel 2.0

Item {
    id: root

    property string source: ""
    property string mode: ""

    Column {
        id: column
        anchors.centerIn: parent
        spacing: 2

        Repeater {
            id: rowRepeater
            model: XmlListModel {
                source: root.source
                query: "/Keyboard/" +
                       mode +
                       "/Row"
            }

            Row {
                id: keyRow
                spacing: 2
                anchors.horizontalCenter: parent.horizontalCenter

                Repeater {
                    id: keyRepeater
                    model: XmlListModel {
                        source: root.source
                        query: "/Keyboard/" +
                               mode +
                               "/Row[" +
                               (index + 1) +
                               "]/Key"

                        XmlRole { name: "labels"; query: "@labels/string()" }
                    }

                    Rectangle {
                        width: 50
                        height: 50

                        Text {
                            anchors.centerIn: parent
                            text: labels[0]
                            font.pixelSize: 35
                        }
                    }
                }
            }
        }
    }
}
