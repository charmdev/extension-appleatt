package extension.appleatt;

import extension.appleatt.AppleATTCFFI;
import extension.util.task.*;

class AppleATT extends TaskExecutor {

	private static var initialized:Bool = false;
	private static var instance:AppleATT = null;

	private static var __available:Void->Bool = function() { return false; };
	private static var __getTrackingAuthorizationStatus:Void->Int = function() { return -1; };
	private static var __requestTrackingAuthorization:Void->Void = function() { };
	private static var __getAdvertisingIdentifier:Void->String = function() { return ""; };
	
	public static function getInstance():AppleATT {
		if (instance == null) instance = new AppleATT();
		return instance;
	}

	private function new() {
		super();
	}

	public function init():Void {

#if android
		return false;
#end

		if (initialized) return;
		initialized = true;

		try {
			__available = cpp.Lib.load("appleatt","appleatt_available", 0);
			__getTrackingAuthorizationStatus = cpp.Lib.load("appleatt","appleatt_getTrackingAuthorizationStatus", 0);
			__requestTrackingAuthorization = cpp.Lib.load("appleatt","appleatt_requestTrackingAuthorization", 0);
			__getAdvertisingIdentifier = cpp.Lib.load("appleatt","appleatt_getAdvertisingIdentifier", 0);
		}
		catch(e:Dynamic) {
			trace("AppleATT INIT Exception: " + e);
		}
	}

	public function requestTrackingAuthorization(_cb):Void {

		trace("AppleATT requestTrackingAuthorization");

		var fOnResult = function() {

			trace("AppleATT requestTrackingAuthorization cb");

			addTask(new CallTask(_cb));
		}

		AppleATTCFFI.setOnResultCallback(fOnResult);

		__requestTrackingAuthorization();
	}

	public function available():Bool {
		return __available();
	}

	public function getTrackingAuthorizationStatus():Int {
		return __getTrackingAuthorizationStatus();
	}

	public function getAdvertisingIdentifier():String {
		return __getAdvertisingIdentifier();
	}

}
