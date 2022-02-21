#import <AppleATT.h>
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/ASIdentifierManager.h>

extern "C" void onResultCallback();


namespace extension_appleatt {

	const char* stringTransformToLatin(const char *value) {
		
		NSString *sentence = [NSString stringWithUTF8String:value];
		
		NSMutableString *buffer = [sentence mutableCopy];
		CFMutableStringRef bufferRef = (__bridge CFMutableStringRef)buffer;
		CFStringTransform(bufferRef, NULL, kCFStringTransformToLatin, false);
		CFStringTransform(bufferRef, NULL, kCFStringTransformStripDiacritics, false);
		NSArray *arr = [buffer componentsSeparatedByString:@" "];
		NSLog(@"%@", arr[0]);

		return [arr[0] UTF8String];
	}

	bool available() {
		if (@available(iOS 14, *))
			return true;

		return false;
	}

	int getTrackingAuthorizationStatus() {

		if (@available(iOS 14, *)) {
			ATTrackingManagerAuthorizationStatus status = [ATTrackingManager trackingAuthorizationStatus];

			BOOL isiOSAppOnMac = [NSProcessInfo processInfo].isiOSAppOnMac;
			//NSLog(@"%@", isiOSAppOnMac ? @"iOS app on Mac" : @"not iOS app on Mac");

			if (isiOSAppOnMac) {
				return 3;
			}

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

			BOOL isiOSAppOnMac = [NSProcessInfo processInfo].isiOSAppOnMac;
			//NSLog(@"%@", isiOSAppOnMac ? @"iOS app on Mac" : @"not iOS app on Mac");

			if (isiOSAppOnMac) {
				dispatch_async(dispatch_get_main_queue(), ^{
					onResultCallback();
				});
				return;
			}

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

}
