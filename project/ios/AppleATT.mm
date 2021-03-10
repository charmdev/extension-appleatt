#import <AppleATT.h>
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/ASIdentifierManager.h>

extern "C" void onResultCallback();


namespace extension_appleatt {

	bool available() {
		if (@available(iOS 14, *))
			return true;

		return false;
	}

	int getTrackingAuthorizationStatus() {

		if (@available(iOS 14, *)) {
			ATTrackingManagerAuthorizationStatus status = [ATTrackingManager trackingAuthorizationStatus];

			switch (status) {
				case ATTrackingManagerAuthorizationStatusAuthorized:
					NSLog(@"getTrackingAuthorizationStatus Authorized 3 ");
					break;

				case ATTrackingManagerAuthorizationStatusDenied:
					NSLog(@"getTrackingAuthorizationStatus Denied 2");
					break;

				case ATTrackingManagerAuthorizationStatusNotDetermined:
					NSLog(@"getTrackingAuthorizationStatus Not Determined 0");
					break;

				case ATTrackingManagerAuthorizationStatusRestricted:
					NSLog(@"getTrackingAuthorizationStatus Restricted 1");
					break;

				default:
					NSLog(@"getTrackingAuthorizationStatus Unknown");
					break;
			}

			return status;
		}

		return -1;
	}

	void requestTrackingAuthorization() {

		//__block NSInteger result = -1;
		
		if (@available(iOS 14, *)) {
			[ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {

				switch (status) {
					case ATTrackingManagerAuthorizationStatusAuthorized:
						// Tracking authorization dialog was shown
						// and we are authorized
						NSLog(@"requestTrackingAuthorization Authorized 3");
						dispatch_async(dispatch_get_main_queue(), ^{
							//onResultCallback("Authorized");
							onResultCallback();
						});
						break;

					case ATTrackingManagerAuthorizationStatusDenied:
						// Tracking authorization dialog was
						// shown and permission is denied
						NSLog(@"requestTrackingAuthorization Denied 2");
						dispatch_async(dispatch_get_main_queue(), ^{
							//onResultCallback("Denied");
							onResultCallback();
						});
						break;

					case ATTrackingManagerAuthorizationStatusNotDetermined:
						// Tracking authorization dialog has not been shown
						NSLog(@"requestTrackingAuthorization Not Determined 0");
						dispatch_async(dispatch_get_main_queue(), ^{
							//onResultCallback("NotDetermined");
							onResultCallback();
						});
						break;

					case ATTrackingManagerAuthorizationStatusRestricted:
						NSLog(@"requestTrackingAuthorization Restricted 1");
						dispatch_async(dispatch_get_main_queue(), ^{
							//onResultCallback("Restricted");
							onResultCallback();
						});
						break;

					default:
						NSLog(@"requestTrackingAuthorization Unknown");
						dispatch_async(dispatch_get_main_queue(), ^{
							//onResultCallback("Unknown");
							onResultCallback();
						});
						break;
				}

			}];
		}
	}

	const char* getAdvertisingIdentifier() {

		return "";
	}
	

}
