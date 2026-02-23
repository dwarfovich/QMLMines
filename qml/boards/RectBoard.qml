import QtQuick
import Felgo 4.0

Item{
    id: rectBoard

    readonly property string name: "Rectangle"
    property int cols: 5
    property int rows: 5
    // property var cells: []

    property real rawCellWidth: width / cols
    property real rawCellHeight: height / rows
    readonly property real maxCellSize: 60
    readonly property real minCellSize: 20
    property real cellSize: Math.max(minCellSize, Math.min(maxCellSize, Math.min(rawCellWidth, rawCellHeight)))
    property real fieldStartX: (width - cellSize*cols)/2
    // anchors.fill: parent
    Rectangle {
        id: rect
        color: "transparent"
        border.color: "blue"
        border.width: 2
        radius: 4
        anchors.fill: parent
    }

    property var cellsArray: []
    Component {
        id: cellComponent
        Cell {}
    }

    function createBoard(rows, cols) {
        let index = 0
        for (let r = 0; r < rows; r++) {
            for (let c = 0; c < cols; c++) {
                let cell = cellComponent.createObject(rectBoard, {
                                                          cellId: index,
                                                          width: Qt.binding(() => rectBoard.cellSize),
                                                                              height: Qt.binding(() => rectBoard.cellSize),

                                                                              x: Qt.binding(() => fieldStartX + c * rectBoard.cellSize),
                                                                              y: Qt.binding(() => r * rectBoard.cellSize)

                                                      })
                cellsArray.push(cell)
                index++
            }
        }
    }

    Component.onCompleted: {
        createBoard(5, 5)
        console.log("Created")
    }

    MouseArea{
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: function(mouse) {
            let c = cellsArray[0]
                    c.revealed = true

                    // IMPORTANT: trigger model update
                    cellsArray = cellsArray
            //console.log("Clicked")
        }
    }

    // resize dynamically if board size changes
    // onWidthChanged: {updateCellSizes(); console.log("width changed!")}
    // onHeightChanged: updateCellSizes()

    // function updateCellSizes() {
    //     for (let i = 0; i < cellsArray.length; i++) {
    //         let r = Math.floor(i / cols)
    //         let c = i % cols
    //         let cell = cellsArray[i]
    //         cell.width = cellSize
    //         cell.height = cellSize
    //         cell.x = c * cellSize
    //         cell.y = r * cellSize
    //     }
    // }
}
