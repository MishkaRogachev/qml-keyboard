import QtQuick 2.0
import QtQuick.XmlListModel 2.0

Item {
    id: root

    property string source
    property int keyWidth: 75
    property int keyHeight: 100
    property int bounds: 2
    property alias mainFont: proxyMainTextItem.font
    property alias mainFontColor: proxyMainTextItem.color
    property alias secondaryFont: proxySecondaryTextItem.font
    property alias secondaryFontColor: proxySecondaryTextItem.color
    property color keyColor: "#34495E"
    property color keyPressedColor: "#1ABC9C"

    property int xmlIndex: 1

    property bool allUpperCase: false

    signal keyClicked(string key)
    signal switchSource(string source)
    signal enterClicked()

    Text {
        id: proxyMainTextItem
        color: "#F2F2F2"
        font.pointSize: 36
        font.weight: Font.Light
        font.family: "Roboto"
        font.capitalization: root.allUpperCase ? Font.AllUppercase :
                                                 Font.MixedCase
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    Text {
        id: proxySecondaryTextItem
        color: "#95A5A6"
        font.pointSize: 18
        font.weight: Font.Light
        font.family: "Roboto"
        font.capitalization: root.allUpperCase ? Font.AllUppercase :
                                                 Font.MixedCase
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
                property int rowIndex: index
                anchors.horizontalCenter: if(parent) parent.horizontalCenter

                Repeater {
                    id: keyRepeater
                    
                    model: XmlListModel {
                        source: root.source
                        query: "/Keyboard/Row[" + (rowIndex + 1) + "]/Key"

                        XmlRole { name: "labels"; query: "@labels/string()" }
                        XmlRole { name: "ratio"; query: "@ratio/number()" }
                        XmlRole { name: "icon"; query: "@icon/string()" }
                        XmlRole { name: "checkable"; query: "@checkable/string()" }
                    }

                    Key {
                        id: key
                        width: keyWidth * ratio
                        height: keyHeight
                        iconSource: icon
                        mainFont: proxyMainTextItem.font
                        mainFontColor: proxyMainTextItem.color
                        secondaryFont: proxySecondaryTextItem.font
                        secondaryFontColor: proxySecondaryTextItem.color
                        keyColor: root.keyColor
                        keyPressedColor: root.keyPressedColor
                        bounds: root.bounds
                        isChekable: checkable
                        isChecked: isChekable &&
                                   command &&
                                   command === "shift" &&
                                   allUpperCase

                        property var command
                        property var params: labels

                        onParamsChanged: {
                            var labelSplit = params.split(/[|]+/)

                            mainLabel = params.split(/[!|]+/)[0].toString();
                            if (labelSplit[1]) secondaryLabels = labelSplit[1];
                            command = params.split(/[!]+/)[1];
                        }

                        onClicked: {
                            if (command)
                            {
                                var commandList = command.split(":");

                                switch(commandList[0])
                                {
                                    case "source":
                                        root.switchSource(commandList[1])
                                        return;
                                    case "shift":
                                        root.allUpperCase = !root.allUpperCase
                                        return;
                                    case "backspace":
                                        root.keyClicked('\b');
                                        return;
                                    case "enter":
                                        root.enterClicked()
                                        return;
                                    case "tab":
                                        root.keyClicked('\t');
                                        return;
                                    default: return;
                                }
                            }
                            if (mainLabel.length === 1)
                                root.emitKeyClicked(mainLabel);
                        }
                        onAlternatesClicked: root.emitKeyClicked(symbol);
                    }
                }
            }
        }
    }

    function emitKeyClicked(text) {
        keyClicked( allUpperCase ? text.toUpperCase() : text);
    }
}
