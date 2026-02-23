import QtQuick

QtObject {
    id: rectangleFieldGameProperties

    property int width: 15
    property int height: 10

    readonly property int minSize: 1
    readonly property int maxSize: 200

    function setWidth(newWidth) {
        if (newWidth < minSize){
            width = minSize
        } else if (newWidth > maxSize){
            width = maxSize
        } else{
            width = newWidth
        }
    }

    function setHeight(newHeight) {
        height = Math.min(maxSize, Math.max(minSize, newHeight))
    }
}
