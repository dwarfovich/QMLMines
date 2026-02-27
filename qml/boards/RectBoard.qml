import QtQuick
import Felgo 4.0

Item{
    id: rectBoard

    readonly property string name: "Rectangle"
    property var cells: []
    property int mines: 6
    property int rows: 5
    property int cols: 5
    property real rawCellWidth: width / cols
    property real rawCellHeight: height / rows
    readonly property real maxCellSize: 60
    readonly property real minCellSize: 20
    property real cellSize: Math.max(minCellSize, Math.min(maxCellSize, Math.min(rawCellWidth, rawCellHeight)))
    property real fieldStartX: (width - cellSize*cols) / 2

    Component {
        id: cellComponent
        Cell {}
    }

    Rectangle {
        id: rect
        color: "transparent"
        border.color: "blue"
        border.width: 2
        radius: 4
        anchors.fill: parent
    }

    function cellClicked(cellIndex, button){
        if (cellIndex < 0 || cellIndex >= cells.length){
            console.error("Incorret cellId clicked: " + cellIndex)
            return
        }

        console.error("CellId clicked: " + cellIndex)
        revealCell(cellIndex)
    }

    // function openCell(index){
    //     if (index >= 0 && index < cells.length) {
    //         cells[cellIndex].revealed = true
    //     }
    // }

    function revealCell(index){
        if (index < 0 && index >= cells.length) {
            return
        }

        if (cells[index].revealed){
            return
        }

        cells[index].revealed = true
        if (cells[index].hasMine || cells[index].hasFlag){
            return
        }

        if (cells[index].neighborMines() === -1){
            let neighborMines = neighborsMinesCount(index)
            cells[index].setNeighborMines(neighborMines)
            if (neighborMines === 0) {
                let row = Math.floor(index / cols)
                let col = index % cols
                if(row + 1 < rows){
                    revealCell(coordinatesToIndex(row + 1, col))
                }
                if(row - 1 >= 0){
                    revealCell(coordinatesToIndex(row - 1, col))
                }
                if(col + 1 < cols){
                revealCell(coordinatesToIndex(row, col + 1))
                }
                if(col - 1 >= 0){
                    revealCell(coordinatesToIndex(row, col - 1))
                }
                if(row + 1 < rows && col + 1 < cols){
                    revealCell(coordinatesToIndex(row + 1, col + 1))
                }
                if(row - 1 >= 0 && col + 1 < cols){
                    revealCell(coordinatesToIndex(row - 1, col + 1))
                }
                if(row + 1 < rows && col - 1 >= 0){
                    revealCell(coordinatesToIndex(row + 1, col - 1))
                }
                if(row - 1 >= 0 && col - 1 >= 0){
                    revealCell(coordinatesToIndex(row - 1, col - 1))
                }

            }
        }
    }

    function shuffle(array) {
        for (let i = array.length - 1; i >= 1; --i) {
            const j = Math.floor(Math.random() * (i + 1));
            [array[i], array[j]] = [array[j], array[i]];
        }
        return array;
    }

    function createBoard(rows, cols) {
        cells.filter(cell => cell).forEach(cell => cell.destroy())

        cells = Array.from({ length: rows * cols}, () => cellComponent.createObject(rectBoard));
        cells.slice(0, mines).forEach(cell => cell.hasMine = true);
        shuffle(cells)
        cells.forEach((cell, i) => {
                          cell.index = i
                          let row = Math.floor(i / cols)
                          let col = i % cols
                          cell.x = Qt.binding(() => fieldStartX + col * cellSize)
                          cell.y = Qt.binding(() => row * cellSize)
                          cell.width = Qt.binding(() => cellSize)
                          cell.height = Qt.binding(() => cellSize)
                      });
    }

    function coordinatesToIndex(row, col){
        return row * cols + col
    }

    function neighborsMinesCount(index){
        let mines = 0
        let row = Math.floor(index / cols)
        let col = index % cols
        mines += (row + 1 < rows && cells[coordinatesToIndex(row + 1, col)].hasMine)
        mines += (row - 1 >= 0 && cells[coordinatesToIndex(row - 1, col)].hasMine)
        mines += (col + 1 < cols && cells[coordinatesToIndex(row, col + 1)].hasMine)
        mines += (col - 1 >= 0 && cells[coordinatesToIndex(row, col - 1)].hasMine)
        mines += (row + 1 < rows && col + 1 < cols && cells[coordinatesToIndex(row + 1, col + 1)].hasMine)
        mines += (row + 1 < rows && col - 1 >= 0 && cells[coordinatesToIndex(row + 1, col - 1)].hasMine)
        mines += (row - 1 >= 0 && col + 1 < cols && cells[coordinatesToIndex(row - 1, col + 1)].hasMine)
        mines += (row - 1 >= 0 && col - 1 >= 0 && cells[coordinatesToIndex(row - 1, col - 1)].hasMine)

        return mines
    }

    Component.onCompleted: {
        createBoard(5, 5)
        console.log("Created")
    }
}
