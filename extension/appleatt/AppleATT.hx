package extension.appleatt;


class AppleATT {

	private static var initialized:Bool = false;
	private static var instance:AppleATT = null;

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
			__available = cpp.Lib.load("appleatt","appleatt_available", 0);
			__setOnResultHandle = cpp.Lib.load("appleatt","appleatt_setOnResultHandle", 1);
			__getTrackingAuthorizationStatus = cpp.Lib.load("appleatt","appleatt_getTrackingAuthorizationStatus", 0);
			__requestTrackingAuthorization = cpp.Lib.load("appleatt","appleatt_requestTrackingAuthorization", 0);
			__stringTransformToLatin = cpp.Lib.load("appleatt","appleatt_stringTransformToLatin", 1);
		}
		catch(e:Dynamic) {
			trace("AppleATT INIT Exception: " + e);
		}
	}

	public static var onResultEvent:Void->Void = null;

	public function requestTrackingAuthorization(_cb:Void->Void):Void {

		trace("AppleATT requestTrackingAuthorization");

		cb = _cb;

		__setOnResultHandle(cb);

		__requestTrackingAuthorization();
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
