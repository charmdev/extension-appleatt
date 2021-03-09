#ifndef STATIC_LINK
#define IMPLEMENT_API
#endif

#if defined(HX_WINDOWS) || defined(HX_MACOS) || defined(HX_LINUX)
#define NEKO_COMPATIBLE
#endif

#include <hx/CFFI.h>
#include <hxcpp.h>
#include <string>
#include <vector>
#include <AppleATT.h>


AutoGCRoot* _onResultCallback;

static value appleatt_available() {
	return alloc_bool(extension_appleatt::available());
}
DEFINE_PRIM(appleatt_available, 0);


static value appleatt_getTrackingAuthorizationStatus() {
	return alloc_int(extension_appleatt::getTrackingAuthorizationStatus());
}
DEFINE_PRIM(appleatt_getTrackingAuthorizationStatus, 0);


static void appleatt_requestTrackingAuthorization() {
	extension_appleatt::requestTrackingAuthorization();
}
DEFINE_PRIM(appleatt_requestTrackingAuthorization, 0);


static value appleatt_getAdvertisingIdentifier() {
	return alloc_string(extension_appleatt::getAdvertisingIdentifier());
}
DEFINE_PRIM(appleatt_getAdvertisingIdentifier, 0);


void extension_appleatt::onResultCallback() {
	val_call0(_onResultCallback->get());
}


static value extension_appleatt_setOnResultCallback(value func) {
	_onResultCallback = new AutoGCRoot(func);
	return alloc_null();
}
DEFINE_PRIM(extension_appleatt_setOnResultCallback, 1);


extern "C" void extension_appleatt_main() {
	val_int(0);
}
DEFINE_ENTRY_POINT (extension_appleatt_main);

extern "C" int extension_appleatt_register_prims() {
	return 0;
}
