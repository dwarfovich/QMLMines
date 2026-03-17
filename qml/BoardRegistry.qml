pragma Singleton

import QtQuick

QtObject {
    id: boardRegistry

    property var boards: []

    function registerBoard(name, component) {
        boards.push({
            name: name,
            component: component
        })
    }
}
