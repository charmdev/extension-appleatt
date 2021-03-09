package extension.appleatt;

@:build(ShortCuts.mirrors())
@CPP_DEFAULT_LIBRARY("extension_appleatt")
@CPP_PRIMITIVE_PREFIX("extension_appleatt")
class AppleATTCFFI {

	@CPP public static function setOnResultCallback(f:Void->Void);

}
