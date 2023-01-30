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
    property var inspectorA
    property var ruasA
    property alias  ruasText: rs.text
    ColumnLayout{

        spacing: 0
        Rectangle{
            width: screenWidth
            height: screenHeight * 4/5
            Image {
                id: backpic
                source: "pic1.jpg"
                width: pic1Width
                height: pic1Height * 4/5
            }
            color: "grey"
            ColumnLayout{
                spacing:30
                anchors.centerIn: parent
                Rectangle{
                    anchors.centerIn: parent
                    id: rsRect
                    color: "grey"
                    width: 400
                    height: 500
                    ColumnLayout{
                        anchors.centerIn: parent
                        Text {
//                            anchors.horizontalCenter: parent
                            id: ruas
                            text: "Ruas jalan"
                        }
                        TextField{
                            id:rs
                            placeholderText: "Enter data here"
                        }
                        Text {
                            id: inspector
                            text: "Inspector"
                        }
                        TextField{
                            id : insp
                            placeholderText: "Inspector"
                        }
                        Rectangle{

                            width: rsRect.width *3/5
                            height: rsRect.height/7
                            color: "grey"
                        }
                        RowLayout{
//                            anchors.centerIn: parent
                            spacing: 30
                            MyButton{
                                id: okBtn
                                text: "Ok"
                                onClicked: {
                                    txtInsp.text = insp.text
                                    txtRuas.text = rs.text
                                    inspectorA = insp.text
                                    ruasA = rs.text
//                                    var propInsp = Component.createObject(insp.text)
                                }

                            }
                            MyButton{
                                id: cncBtn
                                text: "cancel"
                                onClicked: {
                                    insp.text = "";
                                    rs.text = "";
                                }
                            }
                        }
                        Rectangle{

                            width: rsRect.width *3/5
                            height: rsRect.height/4
                            color: "grey"
                        }

                        Text {
                            id: txtInsp
//                            text: qsTr("text")
                        }
                        Text {
                            id: txtRuas
                        }
                    }


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
                        text: "Ruas Tol " + ruasA
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
