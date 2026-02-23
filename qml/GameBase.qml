import QtQuick
import Felgo

QtObject {
    id: gameBase
    
    enum State {
        InProgress,
        PlayerLost,
        PLayerWon
    }
    
    property Scene settingsScene: null
    property Scene gameScene: null

    readonly property int time: data.time
    readonly property int state: data.state
    
    QtObject {
        id: data
        property int time: 0
        property int state: gameVase.State.InProgress
    }
    
}
