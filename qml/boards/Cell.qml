import QtQuick

Item {
    property int cellId: -1
    property int neighborMines: 0
    property bool hasMine: false
    property bool hasFlag: false
    property bool revealed: false
    Rectangle {
            anchors.fill: parent
            color: revealed ? "lightgray" : "darkgray"
            border.width: 1
            border.color: "red"
        }
}
