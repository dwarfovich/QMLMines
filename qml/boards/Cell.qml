import QtQuick

Item {
    id: cell
    property int index: -1
    property bool hasMine: false
    property bool hasFlag: false
    property bool revealed: false
    property int _neighborMines: -1

    Rectangle {
        anchors.fill: parent
        color: revealed ? "#ECECEC" : "#C6C6C6"
        border.width: 0.5
        MouseArea{
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onClicked: (mouse)=>{ rectBoard.cellClicked(cell.index, mouse.button) }
        }
        Text{
            id: neighborsMinesLabel
            anchors.centerIn: parent
            text: ""
            font.pixelSize: 14 + (cell.width - 20) * 0.35
        }
    }

    function neighborMines() {
        return _neighborMines
    }

    function setNeighborMines(mines) {
        console.log(width + " " + height)
        _neighborMines = mines
        if(mines > 0){
            neighborsMinesLabel.text = mines
            neighborsMinesLabel.color = colorForNeighborMines(mines)
        }
    }

    function colorForNeighborMines(mines) {
        switch (mines) {
        case 1: return "#1976D2"
        case 2: return "#388E3C"
        case 3: return "#D32F2F"
        case 4: return "#512DA8"
        case 5: return "#C2185B"
        case 6: return "#0097A7"
        case 7: return "#0097A7"
        case 8: return "#616161"
        default: return ""
        }
    }
}
