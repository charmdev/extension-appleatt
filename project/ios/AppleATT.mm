#import <AppleATT.h>
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/ASIdentifierManager.h>
#import <UIKit/UIKit.h>

extern "C" void onResultCallback();
extern "C" void onRemoveResultCallback();


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

	void showDialog(const char *val1, const char *val2, const char *val3, const char *val4)
	{
		NSString *val1ns = [NSString stringWithUTF8String:val1];
		NSString *val2ns = [NSString stringWithUTF8String:val2];
		NSString *val3ns = [NSString stringWithUTF8String:val3];
		NSString *val4ns = [NSString stringWithUTF8String:val4];

		UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
		UIAlertController *alert = [UIAlertController alertControllerWithTitle:val1ns message:val2ns preferredStyle:UIAlertControllerStyleAlert];
		UIAlertAction *removeAction = [UIAlertAction actionWithTitle:val3ns style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action){
			onRemoveResultCallback();
		}];
		UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:val4ns style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
			
		}];

		[alert addAction:removeAction];
		[alert addAction:cancelAction];
		[rootViewController presentViewController:alert animated:YES completion:nil];
	}

	void exitApp() {
		exit(0);
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
					//NSLog(@"getTrackingAuthorizationStatus Authorized 3 ");
					break;

				case ATTrackingManagerAuthorizationStatusDenied:
					//NSLog(@"getTrackingAuthorizationStatus Denied 2");
					break;

				case ATTrackingManagerAuthorizationStatusNotDetermined:
					//NSLog(@"getTrackingAuthorizationStatus Not Determined 0");
					break;

				case ATTrackingManagerAuthorizationStatusRestricted:
					//NSLog(@"getTrackingAuthorizationStatus Restricted 1");
					break;

				default:
					//NSLog(@"getTrackingAuthorizationStatus Unknown");
					break;
			}

			return status;
		}

		return -1;
	}

	void requestTrackingAuthorization() {
		
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
						//NSLog(@"requestTrackingAuthorization Authorized 3");
						dispatch_async(dispatch_get_main_queue(), ^{
							//onResultCallback("Authorized");
							onResultCallback();
						});
						break;

					case ATTrackingManagerAuthorizationStatusDenied:
						// Tracking authorization dialog was
						// shown and permission is denied
						//NSLog(@"requestTrackingAuthorization Denied 2");
						dispatch_async(dispatch_get_main_queue(), ^{
							//onResultCallback("Denied");
							onResultCallback();
						});
						break;

					case ATTrackingManagerAuthorizationStatusNotDetermined:
						// Tracking authorization dialog has not been shown
						//NSLog(@"requestTrackingAuthorization Not Determined 0");
						dispatch_async(dispatch_get_main_queue(), ^{
							//onResultCallback("NotDetermined");
							onResultCallback();
						});
						break;

					case ATTrackingManagerAuthorizationStatusRestricted:
						//NSLog(@"requestTrackingAuthorization Restricted 1");
						dispatch_async(dispatch_get_main_queue(), ^{
							//onResultCallback("Restricted");
							onResultCallback();
						});
						break;

					default:
						//NSLog(@"requestTrackingAuthorization Unknown");
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
