#include <string>
#include <vector>

#ifndef _APPLEATT_H_
#define _APPLEATT_H_

namespace extension_appleatt {
	
	bool available();
	int getTrackingAuthorizationStatus();
	void requestTrackingAuthorization();
	const char* stringTransformToLatin(const char* value);
	void showDialog(const char *val1, const char *val2, const char *val3, const char *val4);
	void exitApp();
}

#endif
