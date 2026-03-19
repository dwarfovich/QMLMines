import QtQuick 2.15
import Felgo 4.0

Item {
    id: selectGameItem

    property string selectedBoard: ""

    signal backButtonClicked

    Rectangle {
        id: selectGameItemFrame
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"
        border.color: "green"
        border.width: 2
        radius: 4
        width: 150
        height: 100

        Column {
            id: buttonsColumn
            anchors.fill: parent
            spacing: 10

            Repeater {
                model: [{name:"hello", value: 4}, {name:"bye", value: 8}]
                delegate: MainMenuButton {
                    text: modelData.name   // model, not modelData
                    width: parent.width
                    onClicked: {
                        selectGameItem.selectedBoard = modelData.name
                        console.log("Selected board:", modelData.name)
                    }
                }
            }

            MainMenuButton {
                text: "Back"
                onClicked: selectGameItem.backButtonClicked()
            }
        }
    }
}
