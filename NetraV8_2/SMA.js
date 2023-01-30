var MVA = new Array(2);
var sum = new Array(2);
var inputData1 = new Array
var inputData2 = new Array
var flag =0
var i = 0

function sMA(data1, data2, window) {

    if (i === 0){
        MVA[0] = 0;
        sum[0] = 0;
        MVA[1] = 0;
        sum[1] = 0;
    }

    if (flag ===0){
        inputData1[i] = data1;
        inputData2[i] = data2;
        sum[0] += data1;
        sum[1] += data2;
        if (i >=window){
            i = 0;
            flag = 1;

        }
        i++;
    }
    if (flag ===1){
        inputData1[i] = inputData1[i+1];
        inputData2[i] = inputData2[i+1];

        sum[0] += inputData1[i];
        sum[1] += inputData2[i];
        if(i>=(window-1)){
            inputData1[window-1] = data1;
            inputData2[window-1] = data2;
            sum[0] += data1;
            sum[1] += data2;
            i = 0;
//            for (let x=0; x < MVA.length; x++){

//            }
        }
        i++;

    }
    console.log("sum : " + sum[0] )
    MVA[0] = sum[0]/window;
    MVA[1] = sum[1]/window;

    return [MVA[0], MVA[1]];


}
