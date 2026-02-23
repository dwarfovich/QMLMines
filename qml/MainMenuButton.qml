import QtQuick
import Felgo

Rectangle {
    id: button
    // size depends on text + padding
    width: buttonText.implicitWidth + paddingHorizontal*2
    height: buttonText.implicitHeight + paddingVertical*2

    color: "#e9e9e9"
    radius: 10
    //anchors.centerIn: parent
    property int paddingHorizontal: 10
    property int paddingVertical: 5
    property alias text: buttonText.text

    signal clicked

    // center text inside button
    Text {
        id: buttonText
        anchors.centerIn: parent
        font.pixelSize: 18
        color: "black"
        text: "Start game"
    }

    MouseArea {
        id:mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: button.clicked()
        onPressed: button.opacity = 0.5
        onReleased: button.opacity = 1
    }
}
