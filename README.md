# YDHardwareWeb
YDHardwareWeb library for hardware to cache or store datas from bluetooth and display the datas by the html file 

# HardwareDatasStorage
HardwareDatasStorage mainly for cache or store datas with sqlite 


用于悦动圈跑步开放平台的简单demo
问题咨询： qq:295235985  邮箱：zhangminke@51yund.com

第三方最终提供给我们一个framework，模拟器和真机通用的 


#S3.html (this file for interative with oc) 
define the mathod to call the oc in html file

1、this module it not be modified

```
function setupWebViewJavascriptBridge(callback) {
if (window.WebViewJavascriptBridge) { return callback(WebViewJavascriptBridge); }
if (window.WVJBCallbacks) { return window.WVJBCallbacks.push(callback); }
window.WVJBCallbacks = [callback];
var WVJBIframe = document.createElement('iframe');
WVJBIframe.style.display = 'none';
WVJBIframe.src = 'https://__bridge_loaded__';
document.documentElement.appendChild(WVJBIframe);
setTimeout(function() { document.documentElement.removeChild(WVJBIframe) }, 0)
}
```

2、 invoke the last method to do business neccesary
like that:

```
setupWebViewJavascriptBridge(function(bridge) {
…………………………
to do the business necessary
}
````

3、sj invoke the oc method 
```
var callbackButton = document.getElementById('scanBtn')
callbackButton.innerHTML = 'scanBtn'
callbackButton.onclick = function(e) {
e.preventDefault();
log('JS calling handler "scan peripheral"')
// window.location.href='./peripheralList.html';
bridge.callHandler('onScanS3Click', 'S3', function(response) {
log('JS got response', response)
});
};

```
4、oc invoke the js method , so that we must register the method
```
bridge.registerHandler('deliverCharacteristic', function(data, responseCallback) {
log('data'+data+':'+data.uuid+data.value.value0 +':'+data.value.value1+':'+data.value.value2+':'+data.value.value3+'.');

var stepLabel = document.getElementById('stepLabel');
// stepLabel.innerHTML = 
var calorieLabel = document.getElementById('calorieLabel');
// calorieLabel.innerHTMLp =
var distanceLabel = document.getElementById('distanceLabel');
// distanceLabel.innerHTML = 

responseCallback(responseData);
});
```

5、data deliver protocol:
we must deliver the data by the json format , you can deliver json object or data string and so on which can deliver to the oc 
so we recomend the format si key:value  which is simpler ,it will more eaier to use.
like the data of oc that :
```
@{
@"uuid":c.UUID.UUIDString,
@"value":@{
@"value0":value0,
@"value1":value1,
@"value2":value2,
@"value3":value3
}
};
`````
html file to write format about more detail you can see the project file , it is [S3.html](./testYDHardwareWeb/testYDHardwareWeb/Html/S3.html)


# work flow 

declare : two part 
First party : this is the partner of the yuedong , in change of developing the oc native part of the hardware
Second party: this is the partner of the yuedong partner, in change of developing the html web part of the hardwre

1、second party must give the first party about the info of the hardware ，like that, S3
you must tell me about the datas hao to deliver & how to store in the hardwre which help me to know how to get the datas about the hardware

2、second parth must provide the method name which to invoke the oc method ,so we can write the method with oc languge to reponse to the html method which will be work




