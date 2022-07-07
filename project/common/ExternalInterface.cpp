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


static AutoGCRoot* _onResultHandle;
static AutoGCRoot* _onRemoveResultHandle;


static void appleatt_exitApp() {
	extension_appleatt::exitApp();
}
DEFINE_PRIM(appleatt_exitApp, 0);


static void appleatt_showDialog(value val1, value val2, value val3, value val4) {
	extension_appleatt::showDialog(val_string(val1), val_string(val2), val_string(val3), val_string(val4));
}
DEFINE_PRIM(appleatt_showDialog, 4);


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


static value appleatt_stringTransformToLatin(value val) {
	return alloc_string(extension_appleatt::stringTransformToLatin(val_string(val)));
}
DEFINE_PRIM(appleatt_stringTransformToLatin, 1);


extern "C" void onResultCallback()
{
	val_call0(_onResultHandle->get());
}

extern "C" void onRemoveResultCallback()
{
	val_call0(_onRemoveResultHandle->get());
}


static value appleatt_setOnResultHandle(value func) {
	_onResultHandle = new AutoGCRoot(func);
	return alloc_null();
}
DEFINE_PRIM(appleatt_setOnResultHandle, 1);

static value appleatt_setOnRemoveResultHandle(value func) {
	_onRemoveResultHandle = new AutoGCRoot(func);
	return alloc_null();
}
DEFINE_PRIM(appleatt_setOnRemoveResultHandle, 1);


extern "C" void extension_appleatt_main() {
	val_int(0);
}
DEFINE_ENTRY_POINT (extension_appleatt_main);

extern "C" int extension_appleatt_register_prims() {
	return 0;
}
