import QtQuick
import Felgo

QtObject {
    id: commonFieldProperties
    
    readonly property int minesCount : 0
    readonly property int flagsSet : 0
    readonly property int cellsCount : 0
    readonly property int cellsRevealed : 0
    
    function setMinesCount(newCount) {
        minesCOunt = Math.max(1, newCount)
    }
}
