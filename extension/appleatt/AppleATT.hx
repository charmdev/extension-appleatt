package extension.appleatt;


class AppleATT {

	private static var initialized:Bool = false;
	private static var instance:AppleATT = null;

	private static var __exitApp:Void->Void = function() { };
	private static var __showDialog:String->String->String->String->Void = function(val1:String, val2:String, val3:String, val4:String) { }
	private static var __setOnRemoveResultHandle:Dynamic->Void = function(cb:Dynamic) { };

	private static var __available:Void->Bool = function() { return false; };
	private static var __setOnResultHandle:Dynamic->Void = function(cb:Dynamic) { };
	private static var __getTrackingAuthorizationStatus:Void->Int = function() { return -1; };
	private static var __requestTrackingAuthorization:Void->Void = function() { };
	private static var __stringTransformToLatin:String->String = function(value:String) { return ""; };

	private static var cb:Void->Void;
	
	public static function getInstance():AppleATT {
		if (instance == null) instance = new AppleATT();
		return instance;
	}

	private function new() {
		
	}

	public function init():Void {

#if android
		return false;
#end

		if (initialized) return;
		initialized = true;

		try {
			__showDialog = cpp.Lib.load("appleatt","appleatt_showDialog",4);
			__exitApp = cpp.Lib.load("appleatt","appleatt_exitApp", 0);
			__available = cpp.Lib.load("appleatt","appleatt_available", 0);
			__setOnResultHandle = cpp.Lib.load("appleatt","appleatt_setOnResultHandle", 1);
			__setOnRemoveResultHandle = cpp.Lib.load("appleatt","appleatt_setOnRemoveResultHandle", 1);
			__getTrackingAuthorizationStatus = cpp.Lib.load("appleatt","appleatt_getTrackingAuthorizationStatus", 0);
			__requestTrackingAuthorization = cpp.Lib.load("appleatt","appleatt_requestTrackingAuthorization", 0);
			__stringTransformToLatin = cpp.Lib.load("appleatt","appleatt_stringTransformToLatin", 1);
		}
		catch(e:Dynamic) {
			trace("AppleATT INIT Exception: " + e);
		}
	}

	public static var onRemoveResultEvent:Void->Void = null;
	public static var onResultEvent:Void->Void = null;

	public function requestTrackingAuthorization(_cb:Void->Void):Void {
		cb = _cb;
		__setOnResultHandle(cb);
		__requestTrackingAuthorization();
	}

	public function showDialog(val1:String, val2:String, val3:String, val4:String, cb:Void->Void):Void {
		__setOnRemoveResultHandle(cb);
		return __showDialog(val1, val2, val3, val4);
	}

	public function exitApp():Void {
		return __exitApp();
	}

	public function available():Bool {
		return __available();
	}

	public function getTrackingAuthorizationStatus():Int {
		return __getTrackingAuthorizationStatus();
	}

	public function stringTransformToLatin(val:String):String {
		return __stringTransformToLatin(val);
	}

}
