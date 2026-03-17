import QtQuick
import Felgo 4.0

Item{
    id: rectBoard

    readonly property string name: "Rectangle2"
    property var cells: []
    property int mines: 4
    property int rows: 4
    property int cols: 4
    property real rawCellWidth: width / cols
    property real rawCellHeight: height / rows
    readonly property real maxCellSize: 60
    readonly property real minCellSize: 20
    property real cellSize: Math.max(minCellSize, Math.min(maxCellSize, Math.min(rawCellWidth, rawCellHeight)))
    property real fieldStartX: (width - cellSize * cols) / 2
    property int gameState: RectBoard.GameState.InProgress
    property bool firstCellRevealed: false
    property int _revealedCells: 0

    enum GameState{
        InProgress,
        Win,
        Loss
    }

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
        if (gameState !== RectBoard.GameState.InProgress) {
            return
        }

        if (cellIndex < 0 || cellIndex >= cells.length){
            console.error("Incorrect cellId clicked: " + cellIndex)
            return
        }

        if (button === Qt.LeftButton) {
            let newGameState = onLeftClick(cellIndex)
            if (newGameState !== RectBoard.GameState.InProgress){
                finishGame(newGameState)
            }
        } else if (button === Qt.RightButton && !cells[cellIndex].revealed) {
            cells[cellIndex].hasFlag = !cells[cellIndex].hasFlag
        }
    }

    function onLeftClick(cellIndex) {
        if (cells[cellIndex].revealed || cells[cellIndex].hasFlag) {
            return RectBoard.GameState.InProgress
        }

        if (!firstCellRevealed){
            if (cells[cellIndex].hasMine){
                moveFirstMine(cellIndex)
            }
            firstCellRevealed = true
        }

        revealCell(cellIndex)
        if(cells[cellIndex].hasMine){
            return RectBoard.GameState.Loss
        } else if (_revealedCells === cells.length - mines){
            return RectBoard.GameState.Win
        }
        return RectBoard.GameState.InProgress
    }

    function moveMineToClosedCell(indexFrom, indexTo){
        if(indexFrom < 0 || indexFrom >= cells.length) {
            return false
        }
        if(indexTo < 0 || indexTo >= cells.length) {
            return false
        }
        if(indexFrom === indexTo){
            return false
        }
        if(!cells[indexFrom].hasMine || cells[indexTo].hasMine){
            return false
        }
        if(cells[indexFrom].revealed || cells[indexTo].revealed){
            return false
        }

        cells[indexFrom].hasMine = false
        cells[indexTo].hasMine = true
        return true
    }

    function moveFirstMine(cellIndex) {
        let emptyCellIndex = Math.floor(Math.random() * cells.length);
        let leftIndex = emptyCellIndex + 1
        let rightIndex = emptyCellIndex
        do {
            if(leftIndex > 0) {
                --leftIndex
                if(leftIndex !== cellIndex && moveMineToClosedCell(cellIndex, leftIndex)) {
                    return true
                }
            }
            if(rightIndex < cells.length - 1){
                ++rightIndex
                if(rightIndex !== cellIndex && moveMineToClosedCell(cellIndex, rightIndex)){
                    return true
                }
            }
        } while(leftIndex > 0 || rightIndex < cells.length - 1)
        return false
    }

    function finishGame(newGameState) {
        if (newGameState === RectBoard.GameState.Loss || newGameState === RectBoard.GameState.Win){
            gameState = newGameState
        } else {
            return
        }

        cells.forEach((cell)=>{
                          revealCell(cell.index);
                          if (cell.hasMine && !cell.hasFlag && gameState === RectBoard.GameState.Win){
                              cell.hasFlag = true
                          }
                      })
    }

    function revealCell(index){
        if (index < 0 && index >= cells.length) {
            return
        }

        if (cells[index].revealed){
            return
        }

        cells[index].revealed = true
        ++_revealedCells
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
        //createBoard(4, 4)
        //console.log("Created")
    }
}
