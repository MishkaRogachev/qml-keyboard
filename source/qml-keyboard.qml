import QtQuick 2.0
import QtQuick.XmlListModel 2.0

Rectangle {
    id: root
    color: "#2C3E50"
    width: column.width
    height: column.height

    XmlListModel {
        id: model
        source: "xmlrole.xml"

        // XmlRole queries will be made on <book> elements
        query: "/catalogue/book"

        // query the book title
        XmlRole { name: "title"; query: "title/string()" }

        // query the book's year
        XmlRole { name: "year"; query: "year/number()" }

        // query the book's type (the '@' indicates 'type' is an attribute, not an element)
        XmlRole { name: "type"; query: "@type/string()" }

        // query the book's first listed author (note in XPath the first index is 1, not 0)
        XmlRole { name: "first_author"; query: "author[1]/string()" }
    }


    Column {
        id: column
        anchors.centerIn: parent
        spacing: 2

        Repeater {
            id: rowRepeater
            model: model

            Row {
                id: row
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 2

                Repeater {
                    id: buttonRepeater
                    model: 10

                    Rectangle {
                        id: button
                        anchors.verticalCenter: parent.verticalCenter
                        width: 50
                        height: 50
                        color: "#F2F2F2"
                    }
                }

            }
        }
    }

}

