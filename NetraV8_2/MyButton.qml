import QtQuick 2.11
import QtQuick.Controls 2.11
import QtQuick.Controls.Universal 2.11
import QtQuick.Layouts 1.13
import QtQuick.Window 2.11

Button{
    id:button_1
    property color baseColor: "red"
    property color textColor: "black"
    property color conColor: "black"
    property var btnWidth
    property var btnHeight
    property var textSize
    property bool fontBold: false
    text: "Button"
    contentItem: Text {
        anchors.centerIn: rc
        text: button_1.text
        color: button_1.pressed ? "red":textColor
        font.pixelSize: textSize
        font.bold: fontBold
    }

    // To customize the background, you must override the background property
    // namely, install some object that inherits from Item
    // For example Rectangle
        background: Rectangle {
            id:rc
        // The important point for dynamically setting the color is
        // that we control the pressed property of the button we are interested in
        // and depending on its state, set the color
        width: btnWidth
        height: btnHeight
        color: button_1.pressed ? conColor:baseColor           // as background color
        border.color: button_1.pressed ? baseColor:conColor   // so the borders
        border.width: 2
        radius: 5
    }
}
