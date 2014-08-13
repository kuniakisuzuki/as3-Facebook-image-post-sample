
package {
	
	import com.facebook.graph.FacebookDesktop;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	//import com.adobe.images.BitString;
	//import com.adobe.serialization.json.JSON;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	
	public class Main extends Sprite {
		
		protected static const APP_ID:String = ""; // Your App ID.
		protected static const APP_ORIGIN:String = ""; //The site URL of your application (specified in your app settings); needed for clearing cookie when logging out
		
		public function Main() {	
		
			FacebookDesktop.manageSession = false;
			configUI();
		}
		
		function configUI():void {
			//hide the params input by default
			//paramsLabel.visible = paramsInput.visible = false;			
			
			//listeners for UI
			loginToggleBtn.addEventListener(MouseEvent.CLICK, handleLoginClick, false, 0, true);
			callApiBtn.addEventListener(MouseEvent.CLICK, handleCallApiClick, false, 0, true);			
			//getRadio.addEventListener(MouseEvent.CLICK, handleReqTypeChange, false, 0, true);
			//postRadio.addEventListener(MouseEvent.CLICK, handleReqTypeChange, false, 0, true);
			//clearBtn.addEventListener(MouseEvent.CLICK, handleClearClick, false, 0, true);
			
			//Initialize Facebook library
			FacebookDesktop.init(APP_ID, onInit);						
		}
		
		function onInit(result:Object, fail:Object):void {						
			if (result) { //already logged in because of existing session
				outputTxt.text = "onInit, ログイン済みです \n";
				loginToggleBtn.label = "ログアウト";
			} else {
				outputTxt.text = "onInit, ログインしていません \n";
			}
		}
		
		function handleLoginClick(event:MouseEvent):void {
			if (loginToggleBtn.label == "ログイン") {
				var permissions:Array = ["publish_actions"];
				FacebookDesktop.login(onLogin, permissions);				
			} else {
				FacebookDesktop.logout(onLogout, APP_ORIGIN); 
			}
		}
		
		function onLogin(result:Object, fail:Object):void {
			if (result) { //successfully logged in
				outputTxt.appendText("ログインしました　\n");
				loginToggleBtn.label = "ログアウト";
			} else {
				outputTxt.appendText("ログインに失敗・・\n");				
			}
		}
		
		function onLogout(success:Boolean):void {			
			outputTxt.appendText("ログアウトしました　\n");
			loginToggleBtn.label = "ログイン";				
		}
		
		/*
		protected function handleReqTypeChange(event:MouseEvent):void {
			if (getRadio.selected) {			
				paramsLabel.visible = paramsInput.visible = false; 
			} else {
				paramsLabel.visible = paramsInput.visible = true; //only POST request types have params
			}
		}*/
		
		function handleCallApiClick(event:MouseEvent):void {
			//var requestType:String = getRadio.selected ? "GET" : "POST";
			//var params:Object = null;	
			//if (requestType == "POST") {
				//try {
					
					var myBitmapData:BitmapData = new test_image(0, 0);
					var img:Bitmap = new Bitmap(myBitmapData);

					var values:Object = {message:'test!', fileName:'FILE_NAME',picture:img};

					FacebookDesktop.api('/me/photos', onCallApi, values,'POST')
					
					//trace(paramsInput.text);
					//params = JSON.parse(paramsInput.text);
					
				/*} catch (e:Error) {
					outputTxt.appendText("\n\nERROR DECODING JSON: " + e.message);
				}*/
			//}
			//FacebookDesktop.api(methodInput.text, onCallApi, params, requestType); //use POST to send data (as per Facebook documentation)
		}
		
		function onCallApi(result:Object, fail:Object):void {
			if (result) {
				outputTxt.appendText("\n\nRESULT:\n" + JSON.stringify(result)); 
			} else {
				outputTxt.appendText("\n\nFAIL:\n" + JSON.stringify(fail)); 
			}
		}
		
		/*protected function handleClearClick(event:MouseEvent):void {
			outputTxt.text = "";
		}*/
	}
}