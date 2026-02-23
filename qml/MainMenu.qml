import QtQuick 2.15
import Felgo 4.0

Item {
    id: mainMenuItem

    signal newGameRequested
    signal loadGameRequested
    signal quitRequested

    Rectangle {
        id: frame
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"
        border.color: "red"
        border.width: 2
        radius: 4
        width: 150
        height: 100

        MainMenuButton {
            id: startGameButton
            text: "New game"

            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: frame.padding
            anchors.horizontalCenter: parent.horizontalCenter

            onClicked: newGameRequested()
        }

        MainMenuButton {
            id: loadGameButton
            text: "Load"

            anchors.left: parent.left
            anchors.top: startGameButton.bottom
            anchors.topMargin: frame.padding
            anchors.horizontalCenter: parent.horizontalCenter

            onClicked: loadGameRequested()
        }
        MainMenuButton {
            id: quitGameButton
            text: "Quit"

            anchors.left: parent.left
            anchors.top: loadGameButton.bottom
            anchors.topMargin: frame.padding
            anchors.horizontalCenter: parent.horizontalCenter

            onClicked: quitRequested()
        }
    }
}
