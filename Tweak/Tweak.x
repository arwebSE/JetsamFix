#import <dlfcn.h>
#import <os/log.h>
#import <string.h>
#import "Tweak.h"
#include <RemoteLog.h> // DEBUG

BOOL enabled;

#define hasPrefix(string, prefix) (strncmp(prefix, string, strlen(prefix)) == 0) // Credits: KritantaDev

%group JetsamFix

%hookf(void *, dlopen, const char *path, int mode) {
	if (path != NULL &&
		(hasPrefix(path, "/Library/MobileSubstrate/DynamicLibraries") || hasPrefix(path, "/usr/lib/TweakInject")) &&
		strcmp(path, "/Library/MobileSubstrate/DynamicLibraries/mrybootstrap.dylib") != 0 &&
		strcmp(path, "/usr/lib/TweakInject/mrybootstrap.dylib") != 0) {

		os_log(OS_LOG_DEFAULT, "JetsamFix: Loading of %{public}s was blocked.", path); // LOG
		return NULL; // Block injection
	}
	return %orig;
}
%end // End hook

// %end // End group

%ctor {
	preferences = [[HBPreferences alloc] initWithIdentifier:@"se.arweb.jfprefs"];
  	[preferences registerBool:&enabled default:YES forKey:@"Enabled"];

	NSDateFormatter *timeformatter = [[NSDateFormatter alloc] init];
	[timeformatter setTimeStyle: NSDateFormatterShortStyle];
	[timeformatter setDateFormat:@"hh:mm:ss a"];
	NSString *Time  = [timeformatter stringFromDate:[NSDate date]];

	if (enabled) {
		RLog(@"[%@]JetsamFix: Tweak enabled!", Time); // DEBUG
		%init(JetsamFix);
  	} else {
		RLog(@"[%@]JetsamFix: Tweak disabled.", Time); // DEBUG
	}
}
