#include <string>
#include <vector>

#ifndef _APPLEATT_H_
#define _APPLEATT_H_

namespace extension_appleatt {
	
	bool available();

	int getTrackingAuthorizationStatus();

	void requestTrackingAuthorization();
	
	const char* stringTransformToLatin(const char* value);
	
}

#endif
