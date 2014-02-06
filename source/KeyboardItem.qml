import QtQuick 2.0
import QtQuick.XmlListModel 2.0

Item {
    id: root

    property string source
    property int keyWidth: 75
    property int keyHeight: 100
    property alias font: proxyTextItem.font
    property alias fontColor: proxyTextItem.color
    property color keyColor: "#34495E"
    property color keyPressedColor: "#1ABC9C"

    property int xmlIndex: 1

    signal keyClicked(string key)
    signal switchMode(string mode)

    Text {
        id: proxyTextItem
        color: "#F2F2F2"
        font.pointSize: 36
        font.weight: Font.Light
        font.family: "Roboto"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    Column {
        id: column
        anchors.centerIn: parent

        Repeater {
            id: rowRepeater
            model: XmlListModel {
                source: root.source
                query: "/Keyboard/Row"
            }

            Row {
                id: keyRow
                anchors.horizontalCenter: parent.horizontalCenter

                Repeater {
                    id: keyRepeater
                    model: XmlListModel {
                        source: root.source
                        query: "/Keyboard/Row[" + (index + 1) + "]/Key"

                        XmlRole { name: "labels"; query: "@labels/string()" }
                        XmlRole { name: "ratio"; query: "@ratio/number()" }
                        XmlRole { name: "icon"; query: "@icon/string()" }
                    }

                    Key {
                        width: keyWidth * ratio
                        height: keyHeight
                        text: labels.split(/[!|]+/)[0].toString();
                        iconSource: icon
                        font: proxyTextItem.font
                        fontColor: proxyTextItem.color
                        keyColor: root.keyColor
                        keyPressedColor: root.keyPressedColor
                        onClicked: {
                            var command = labels.split(/[!]+/)[1];

                            if (command)
                            {
                                var commandList = command.split(":");

                                switch(commandList[0])
                                {
                                    case "mode":
                                        root.switchMode(commandList[1])
                                        return;
                                    default:
                                        return;
                                }
                            }

                            if(text.length === 1) root.keyClicked(text);
                        }
                    }
                }
            }
        }
    }
}
