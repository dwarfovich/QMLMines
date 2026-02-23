import QtQuick 2.15
import Felgo 4.0

Item {
    id: selectGameItem

    signal backButtonClicked

    Rectangle {
        id: selectGameItemFrame
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"
        border.color: "red"
        border.width: 2
        radius: 4
        width: 150
        height: 100

        MainMenuButton {
            id: rectButton
            text: "Rect"

            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: selectGameItemFrame.padding
            anchors.horizontalCenter: parent.horizontalCenter
        }

        MainMenuButton {
            id: backButton
            text: "Back"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: selectGameItemFrame.padding
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: backButtonClicked()
        }
    }
}
