import QtQuick
import Felgo

Scene {
    id: rectScene

    property Scene previousMenu: null

    Item {
        anchors.fill: parent

        Column {
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 40
            spacing: 20

            MainMenuButton {
                text: "Width"
            }

            MainMenuButton {
                text: "Height"
            }

            MainMenuButton {
                id: buttonBack
                text: "Back"
                onClicked: {
                    if (previousMenu) {
                        gameWindow.activeScene = previousMenu
                        gameWindow.activeScene.visible = true
                        gameWindow.activeScene.enabled = true
                        console.log("Back to previous menu")
                    } else {
                        console.warn("previousMenu is null")
                    }
                }
            }
        }
    }
}
