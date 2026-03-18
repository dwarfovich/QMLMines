import Felgo 4.0
import QtQuick 2.15
import "boards" as Boards
//import "." as Core

GameWindow {
    id: gameWindow

    state: "mainMenu"

    states: [
        State {
            name: "mainMenu"
            PropertyChanges {target: mainMenu; opacity: 1; visible: true}
            PropertyChanges {target: selectGameMenu; opacity: 0; visible: false}
        },
        State {
            name: "newGame"
            PropertyChanges {target: mainMenu; opacity: 0; visible: false}
            PropertyChanges {target: selectGameMenu; opacity: 1; visible: true}
            StateChangeScript {
                script: console.log("New game selected:", selectGameMenu.selectedBoard)
            }
        },
        State {
            name: "loadGame"
            StateChangeScript {
                script: console.log("Load game selected")
            }
        }
    ]

    Scene {
        id: scene
        anchors.fill: parent

        Item {
            id: mainItem
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.fill: parent
            Rectangle {
                id: box
                color: "transparent"
                border.color: "white"
                border.width: 2
                radius: 4
                anchors.horizontalCenter: parent.horizontalCenter
                width: label.implicitWidth + 16
                height: label.implicitHeight + 10

                Text {
                    id: label
                    text: "Hello, world!"
                    font.pixelSize: 20
                    color: "white"
                    anchors.centerIn: parent
                }
            }
            MainMenu {
                id: mainMenu
                anchors.top: box.bottom
                anchors.topMargin: 40
                anchors.horizontalCenter: parent.horizontalCenter

                onNewGameRequested: gameWindow.state = "newGame"
                onLoadGameRequested: gameWindow.state = "loadGame"
                onQuitRequested: Qt.quit()
            }
            SelectGameMenu {
                id: selectGameMenu
                anchors.top: box.bottom
                anchors.topMargin: 40
                anchors.horizontalCenter: parent.horizontalCenter
                opacity: 0
                visible: false

                onBackButtonClicked: gameWindow.state = "mainMenu"
            }
            SettingsSceneBase {
                id: gameSettingsMenu
                anchors.top: box.bottom
                anchors.topMargin: 40
                anchors.horizontalCenter: parent.horizontalCenter
                opacity: 0
                visible: false
            }
        }
    }


    Item {
        Loader {
                    id: boardLoader
                    anchors.fill: parent
                }
        Component.onCompleted: {
            console.log("Type:", typeof BoardScanner)
            BoardScanner.search("./qml/boards/")
            console.log(BoardScanner.files)
            // BoardScanner.search("./")
            // for (let file of BoardScanner.files) {
            //         console.log(file)
            //     }
            // //Loader { source: "boards/RectBoard.qml" }
            // console.log("Main window: Component.onCompleted")
            // boardLoader.source = "boards/RectBoard.qml"
        }
    }
}
