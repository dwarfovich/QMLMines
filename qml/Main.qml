import Felgo 4.0
import QtQuick 2.15
import "boards" as Boards

GameWindow {
    id: gameWindow

    state: "mainMenu"

    states: [
        // State {
        //     name: "mainMenu"
        //     PropertyChanges {target: mainMenu; opacity: 1; visible: true}
        //     PropertyChanges {target: selectGameMenu; opacity: 0; visible: false}
        // },
        // State {
        //     name: "newGame"
        //     PropertyChanges {target: mainMenu; opacity: 0; visible: false}
        //     PropertyChanges {target: selectGameMenu; opacity: 1; visible: true}
        //     StateChangeScript {
        //         script: console.log("New game selected.")
        //     }
        // },
        // State {
        //     name: "loadGame"
        //     StateChangeScript {
        //         script: console.log("Load game selected")
        //     }
        // }
    ]

    Scene {
        anchors.fill: parent
        Item {
                id: boardContainer
                anchors.fill: parent
                //anchors.margins: 20

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
                Boards.RectBoard{
                    anchors.horizontalCenter: box.horizontalCenter

                    anchors.topMargin: 20
                    anchors.top: box.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    //width: parent.width
                    //height: 100
                    anchors.bottom: parent.bottom

                }
            }



        // Item {
        //     id: someItem
        //     anchors.horizontalCenter: box.horizontalCenter
        //     anchors.top: box.bottom
        //     anchors.topMargin: 20
        //     width: 200
        //     height: 200
        //     function reveal(h){
        //         console.log("rectangle clicked: " + h)
        //     }
        //     function setFlag(h){
        //         console.log("rectangle flagged: " + h)
        //     }

        //     Rectangle {
        //         id: itemBox
        //         property string name: "rect 1"
        //         property int cellId: 1
        //         color: "transparent"
        //         border.color: "red"
        //         border.width: 2
        //         radius: 4
        //         anchors.horizontalCenter: parent.horizontalCenter
        //         width: 100
        //         height: 100
        //         MouseArea{
        //             anchors.fill: parent
        //             acceptedButtons: Qt.LeftButton | Qt.RightButton
        //             onClicked: function(mouse) {
        //                 if (mouse.button === Qt.LeftButton){
        //                     parent.parent.reveal(parent.cellId)
        //                 } else if (mouse.button === Qt.RightButton){
        //                     parent.parent.setFlag(parent.cellId)
        //                 }
        //             }

        //         }
        //     }
        //     Rectangle {
        //         id: itemBox2
        //         property string name: "rect 2"
        //         color: "transparent"
        //         border.color: "blue"
        //         border.width: 2
        //         radius: 4
        //         anchors.left: itemBox.right
        //         width: 100
        //         height: 100
        //     }
        //     Rectangle {
        //         color: "transparent"
        //         border.color: "green"
        //         border.width: 2
        //         radius: 4
        //         anchors.fill: parent
        //     }
        // }
    }

    // Scene {
    //     id: minesLabel
    //     anchors.fill: parent

    //     Item {
    //         id: mainItem
    //         anchors.horizontalCenter: parent.horizontalCenter
    //         anchors.fill: parent
    //         Rectangle {
    //             id: box
    //             color: "transparent"
    //             border.color: "white"
    //             border.width: 2
    //             radius: 4
    //             anchors.horizontalCenter: parent.horizontalCenter
    //             width: label.implicitWidth + 16
    //             height: label.implicitHeight + 10

    //             Text {
    //                 id: label
    //                 text: "Hello, world!"
    //                 font.pixelSize: 20
    //                 color: "white"
    //                 anchors.centerIn: parent
    //             }
    //         }
    //         MainMenu {
    //             id: mainMenu
    //             anchors.top: box.bottom
    //             anchors.topMargin: 40
    //             anchors.horizontalCenter: parent.horizontalCenter

    //             onNewGameRequested: gameWindow.state = "newGame"
    //             onLoadGameRequested: gameWindow.state = "loadGame"
    //             onQuitRequested: Qt.quit()
    //         }
    //         SelectGameMenu {
    //                    id: selectGameMenu
    //                    anchors.top: box.bottom
    //                    anchors.topMargin: 40
    //                    anchors.horizontalCenter: parent.horizontalCenter
    //                    opacity: 0
    //                    visible: false

    //                    onBackButtonClicked: gameWindow.state = "mainMenu"
    //                }
    //     }
    // }
}
