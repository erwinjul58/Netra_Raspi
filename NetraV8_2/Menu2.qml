import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Universal 2.15
import QtQuick.Layouts 1.0
import QtQuick.Window 2.15
Page{
    id:wdw2
    width: Screen.width
    height: Screen.height
    visible: true
//    color: "grey"
    title: qsTr("Test SSL")
    property var screenWidth: Screen.width
    property var screenHeight: Screen.height
    property var pic1Width: Screen.width
    property var pic1Height: Screen.height
    property var testext: "value"
    ColumnLayout{
        spacing: 0
        Rectangle{
            width: screenWidth
            height: screenHeight * 4/5
            Image {
                id: backpic
                source: "Connected.png"
                width: pic1Width
                height: pic1Height * 4/5
            }
            color: "grey"
            ColumnLayout{
                anchors.centerIn: parent
                Button{
    //                    baseColor: "blue"
    //                    textColor: "green"
                    text: "Push me"
                    onClicked: {
                        testext = "tol batang"

                    }
                }
                Text {
                    id: txt1
                    text: testext
                }
                TextField{
                    placeholderText: "Enter data here"
                }
            }
        }
        Rectangle{
            id : recBott
            width: screenWidth
            height: screenHeight * 1/3
            color: "white"
            RowLayout{
    //                spacing: 600
                Rectangle{
                    id: place
                    width: screenWidth-400
                    height: 200
                    color: "red"
                    Text {
                        id: tol1
                        anchors.centerIn: parent
                        text: "test tol"
                        font.bold: true
                        color: "white"
                        font.pixelSize: 35
    //                    fon
                    }
                }

                Rectangle{
                    width: 400
                    height: 200
                    color: "red"
                    Image {
                        id: netrapp
                        source: "Ptpp.jpeg"
                        width: 400
                        height: 200
                    }
    //                    Text {
    //                        anchors.centerIn: parent
    //                        id: tol2
    //                        text: "Netra"
    //                        font.bold: true
    //                        color: "white"
    //                        font.pixelSize: 30
    //                    }
                }


            }
        }
    }
}
