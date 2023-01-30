import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Universal 2.15
import QtQuick.Layouts 1.0
import QtQuick.Window 2.15
import QMLSerialPort 1.0
ApplicationWindow {
    id:wdw1
    width: Screen.width
    height: Screen.height
    visible: true
    color: "grey"
    title: qsTr("Netra V8.0")
    Image {
        id: imgc
        source: "pcb.jpg"
        width: Screen.width
        height: Screen.width
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex



//        Menu1{

//        }
//        Menu2{

//        }
        Menu3{

        }


    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

//        TabButton {
//            text: qsTr("Menu 1")
//        }
//        TabButton {
//            text: qsTr("Menu 2")
//        }
        TabButton{
            text: qsTr("Measurements")
        }
    }
//    ColumnLayout{
//        anchors.centerIn: parent
//        MyButton{
//            id: menu1
//            text: "Menu1"
//            baseColor: "green"
//            textColor: "white"
//            textSize: 80
//            onClicked: {
//                var component = Qt.createComponent("Menu1.qml")
//                 var window    = component.createObject()
//                 window.show()
////                pageStack.push(Qt.resolvedUrl("Menu1.qml"))
//            }
//        }
//        MyButton{
//            id: menu2
//            text: "Menu2"
//            baseColor: "blue"
//            textColor: "yellow"
//            textSize: 80
//            onClicked: {
//                var component2 = Qt.createComponent("Menu2.qml")
//                 var window2    = component2.createObject()
//                 window2.show()
////                pageStack.push(Qt.resolvedUrl("Menu1.qml"))
//            }
//        }
//        MyButton{
//            id: menu3
//            text: "Menu3"
//            baseColor: "red"
//            textColor: "white"
//            textSize: 80
//            onClicked: {
//                var component3 = Qt.createComponent("Menu3.qml")
//                 var window3    = component3.createObject()
//                 window3.show()
////                pageStack.push(Qt.resolvedUrl("Menu1.qml"))
//            }
//        }
//    }

//    Menu1{

//    }

}
