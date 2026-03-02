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
        // border.width: 0.5
        MouseArea{
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onClicked: (mouse)=>{ rectBoard.cellClicked(cell.index, mouse.button) }
        }

        Image {
            property int spriteIndex: cell.spriteIndex()
            property int spriteSize: 64
            property int columns: 6

            width: spriteSize
            height: spriteSize
            anchors.fill: parent
            source: "../../assets/cells_square.png"
            sourceClipRect: Qt.rect(
                                (spriteIndex % columns) * spriteSize,
                                Math.floor(spriteIndex / columns) * spriteSize,
                                spriteSize,
                                spriteSize
                                )
        }
        Text{
            id: neighborsMinesLabel
            anchors.centerIn: parent
            text: ""
            font.pixelSize: 14 + (cell.width - 20) * 0.35
        }
    }

    function spriteIndex() {
        if (!revealed){
            return hasFlag ? 1 : 0
        }

        // Revealed cells
        if (hasMine) {
            return hasFlag ? 2 : 4
        }

        if (!hasMine && hasFlag) {
            return 3
        }

        return 5
    }

    function neighborMines() {
        return _neighborMines
    }

    function setNeighborMines(mines) {
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
