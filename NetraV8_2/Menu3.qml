import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Universal 2.15
import QtQuick.Layouts 1.0
import QtQuick.Window 2.15
import QMLSerialPort 1.0
import Wsocket 1.0
import "SMA.js" as Sma

//import
Page {
    id: wdw3
    width: Screen.width
    height: Screen.height
    //    :
    visible: true
    //    color: "lightgrey"
    title: qsTr("Test SSL")
    property var screenWidth: Screen.width
    property var screenHeight: Screen.height
    property var pic1Width: Screen.width
    property var pic1Height: Screen.height
    property color backColor: "lightblue"
    property color depthColor: "green"
    property var ruas
    property var inspector
    property int start: 0
    property int startNozle: 0
    property bool flagSMA: false



    WSocketServer {
        id: ws
//        sendMessage: vcp.s
//        sendMessage: JSON.stringify(vcp.sendJson)
        sendMessage: {
//            JSON.stringify(vcp.jobj)
            vcp.s
        }
//        Menu1{}
    }
//    Menu1{}
    SerialPort {
        id: vcp
        portName: "/dev/ttyACM0"
        baudRate: 2000000
        parity: SerialPort.NoParity
        flowControl: SerialPort.NoFlowControl
        stopBits: SerialPort.OneStop
        property var buffer
        property var jobj
        property string jSonsensore
        property var sendJson
        property var s
        property var frontSensor
        property var backSensor
        property var encoderSensor
        property var distanceSensor
        property int i: 0
        property var sensors: [0,0]
        property var err : true
        property var texbuffer
        property var jsonBuff
        property var distFlag : 0
        property var setDist: 0
        property var getDist: 0
        property var distCount: 0
        onDataReceived: {
            let MVA = [0, 0];
            let sumA = [0,0];
            let tex
//            let texbuffer

            buffer += data
            var end = buffer.indexOf("\r\n")
            if (end >= 0) {

                console.log(buffer.substring(0, end))
                texbuffer = JSON.stringify(buffer.substring(0, end))
                buffer = buffer.substring(end + 2)
                tex = buffer.includes("undefined")
                console.log(tex)
                console.log("json Stringify" + JSON.stringify(buffer.substring(0, end)))
//                texbuffer = JSON.stringify(buffer.substring(0, end))
                console.log("buffering ; "+ texbuffer)
                jsonBuff = texbuffer.replace(/\\/g,"")
                jsonBuff = jsonBuff.replace('\"\{','\{')
                jsonBuff = jsonBuff.replace('\}\"','\}')
                console.log("jsonbuff : " + jsonBuff)

            }

            if(tex===true){
                 buffer= buffer.replace("undefined"," ")
                jobj = JSON.parse(buffer.substring(0, end))
                jobj = JSON.parse((buffer))
//                console.log(texbuffer+"edit")
            }else if(tex===false || jsonBuff.length===0){
//                jobj = JSON.parse(buffer.substring(0, end))
//                jobj = JSON.parse(buffer)
//                    jobj = JSON.parse((texbuffer))
                jobj = JSON.parse((jsonBuff))
//                    jobj = JSON.parse(buffer.substring(0, end))
            }

            sendJson["ipAddress"] = ws.hostIP
            sendJson["maxdepth"] = encoderSensor
            sendJson["position"] = Math.floor(Math.random()*10)
            console.log ("calibration value:" + callibrate.calValBack)
            frontSensor = jobj["front"] - callibrate.calValFront
            backSensor = jobj["back"] - callibrate.calValBack
            encoderSensor = jobj["Encoder"] - callibrate.calDepth
            distanceSensor = jobj["distance"] - callibrate.calDistance
//            s = JSON.stringify(sendJson)
//            sensors = Sma.sMA(frontSensor,backSensor,4);
            console.log("sensor 1:" + sensors[0] + "sensor 2:"+ sensors[1])
//            sensors[0]

            if (start===1){
                testNozzle.nozzletest=0
                if (frontSensor<=70){
                    sendData('a')
                    console.log("command to turn on wiper ")
                 }
                if (frontSensor>70) {
                    sendData('b')
                    console.log("turn off wipper " )
                }
                if (distFlag === 0){
                    setDist = parseInt (jobj["distance"])
                    sendJson["position"] = distCount++
                    s = JSON.stringify(sendJson)
                    distFlag = 1
                }else if(distFlag ===1){
//                    getDist = parseInt (jobj["distance"]) - setDist
                    getDist = (jobj["distance"]) - setDist
                    if (getDist >=5.0){
                        distFlag = 0
                    }
                    if (parseInt(jobj["distance"])>=91914){
                        setDist = 0
                        distCount = 0
                    }
                }
            }else if (start === 0){
                sendData('b');
                close()

            }


        }

    }
    ColumnLayout {
        spacing: 0
        Rectangle {
            width: screenWidth
            height: screenHeight * 4 / 5
            Image {
                id: backpic
                source: "pic1.jpg"
                width: pic1Width
                height: pic1Height * 4 / 5
            }
            color: backColor
            ColumnLayout {
                spacing: 0
                anchors.centerIn: parent

                Rectangle {
                    width: Screen.width
                    height: (screenHeight * 1 / 5) + 50
                    color: backColor
                    ColumnLayout {
                        anchors.centerIn: parent
                        Text {

                            id: empty3
                            text: ""
                            font.bold: true
                            color: "black"
                            font.pixelSize: 45
                        }

                        Text {

                            id: ruas
                            text: "R1 +" + "117 " + " 800"
                            font.bold: true
                            color: "black"
                            font.pixelSize: 50
                        }
                        Text {
                            //                    anchors.centerIn: parent
                            id: name
                            text:  "Hutagaol"
                            font.bold: true
                            color: "black"
                            font.pixelSize: 14
                        }

                    }
                }

                RowLayout {
                    spacing: 0
                    Rectangle {
                        id: depth
                        width: Screen.width / 2
                        height: screenHeight * 4 / 5
                        color: backColor
                        ColumnLayout {
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: 0

                            Text {
                                //                    anchors.centerIn: parent
                                id: deptLabel
                                text: "     Depth(mm)"
                                font.bold: true
                                color: "black"
                                font.pixelSize: 25
                            }
//                            Text {
//                                //                    anchors.centerIn: parent
//                                id: emptylabel
//                                text: ""
//                                font.bold: true
//                                color: "black"
//                                font.pixelSize: 40
//                            }
                            Text {
                                id: tdepth
                                //                                anchors.centerIn: parent
                                text:" " + vcp.encoderSensor.toFixed(3)
                                font.bold: true
                                color: vcp.encoderSensor<68?"red" : depthColor //change color to red when the value more or less than set point/limit
                                font.pixelSize: 100
                                onTextChanged: {

                                }
                            }

//                            }
                            Text {
                                id: ipAddr
                                text: " ws://"+ws.hostIP+":1246"
                                font.bold: true
                                color: "red"
                                font.pixelSize: 25
                            }
                            Text {
                                id: distance
//                                text: "distance :" + vcp.getDist + " cm" + "count : " + vcp.distCount
                                font.bold: true
                                color: "red"
                                font.pixelSize: 15
                            }
                            RowLayout{
                                spacing: 40
                                MyButton {
                                    id: btnStart
                                    text: "Start"
                                    btnWidth: 70
                                    btnHeight: 50
                                    textSize: 25
                                    baseColor: "blue"
                                    onClicked: {
                                        vcp.open();
                                        let send = '{ "Start" : 1}'
                                        vcp.sendData(send)
                                        vcp.sendJson = {"device_id" : "device001", "ipAddress" : "null",
                                            "position" : 0, "width" : null, "maxdepth": 70, "sensor_position" : "depan"}
                                        start = 1
                                    }
                                }
                                MyButton {
                                    id : stopButton
                                    text: "stop"
                                    btnWidth: 70
                                    btnHeight: 50
                                    textSize: 25
                                    onClicked: {
//                                        let send = '{ "Start" : 0}'
                                        vcp.open()
                                        start = 0
                                        vcp.sendData('b');
//                                        vcp.close();

                                    }
                                }
                                MyButton {
                                    id : callibrate
                                    text: "callibrate"
                                    btnWidth: 130
                                    btnHeight: 50
                                    textSize: 25
                                    property  int calValBack: 0
                                    property var calValFront: 0
                                    property var calDepth: 0
                                    property var calDistance: 0
                                    onClicked: {
//                                        if (vcp.open()){
                                        start = 0
                                        vcp.open()
//                                        vcp.send('b')
//                                        let send = '{ "callibrate" : 1}'
                                        calValFront = vcp.jobj["front"]
                                        calValBack = vcp.jobj["back"]
                                        calDepth = vcp.jobj["Encoder"]
                                        calDistance = vcp.jobj["distance"]
//                                        }else{
//                                            console.log("cek connection")
//                                        }

                                    }
                                }
                                MyButton{
                                    id: testNozzle
                                    text: "Nozzle Test"
                                    btnWidth: 140
                                    btnHeight: 50
                                    textSize: 25
                                    property int nozzletest
                                    onClicked: {
//                                        nozzletest==0?nozzletest=!nozzletest:nozzletest=!nozzletest
                                        vcp.open();
                                        vcp.sendData('b');
                                        nozzletest = 1;

                                    }
                                }
                            }
                        }
                    }
                    ColumnLayout {
                        spacing: 0

                        Rectangle {
                            width: depth.width
                            height: depth.height / 3
                            color: backColor
                            ColumnLayout {
                                //                                anchors.centerIn: parent
                                anchors.horizontalCenter: parent.horizontalCenter
                                //                                spacing: 20
                                Text {
                                    id: foreText
                                    //                                    anchors.centerIn: parent
                                    text: qsTr("Sensor")
                                    font.bold: true
                                    color: "grey"
                                    font.pixelSize: 40
                                }
                                Text {
                                    id: front

                                    //                                    anchors.centerIn: parent
                                    text: vcp.encoderSensor
                                    font.bold: true
                                    color: "black" //change this when over limit
                                    font.pixelSize: 60
                                }
                            }
                        }
                        Rectangle {
                            width: depth.width
                            height: depth.height / 3
                            color: backColor
                            ColumnLayout {
//                                                                anchors.verticalCenter: parent.verticalCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                                Text {
                                    id: backa
                                    //                                    anchors.centerIn: parent
                                    text: qsTr("Distance")
                                    font.bold: true
                                    color: "grey"
                                    font.pixelSize: 40
                                }
                                Text {
                                    id: backS
                                    //                                    anchors.centerIn: parent
                                    text: vcp.distanceSensor.toFixed(2)
                                    font.bold: true
                                    color: "black" //change this when over limit
                                    font.pixelSize: 60
                                }
                            }
                        }
                        Rectangle {
                            width: depth.width
                            height: depth.height / 3
                            color: backColor
                        }
                    }
                }
            }
        }
        Rectangle {
            id: recBott
            width: screenWidth
            height: (screenHeight * 1 / 3) + 500
            color: "red"
            RowLayout {
                Rectangle {
                    id: place
                    width: screenWidth + 400
                    height: 100
                    color: "red"

                    ColumnLayout {
//                        anchors.centerIn: parent
                        Text {
                            id: tol1
                            text: ruas
                            font.bold: true
                            color: "white"
                            font.pixelSize: 35
                        }
                        Text {
                            id: inspector
                            text: Menu1.inspectorA
                            font.bold: true
                            color: "white"
                            font.pixelSize: 35
                        }
                    }
                }

                Rectangle {
                    width: 400
                    height: (screenHeight * 1 / 3) + 500
                    color: "white"
                    Image {
                        id: netrapp
                        source: "netra1.png"
                        width: 400
                        height: 200
                    }
                }
            }
        }
    }
}
