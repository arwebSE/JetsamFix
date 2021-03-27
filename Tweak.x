#import <dlfcn.h>
#import <os/log.h>
#include <RemoteLog.h> // DEBUG

static BOOL hasPrefix(const char *string, const char *prefix) {
	return strncmp(prefix, string, strlen(prefix)) == 0;
}

%hookf(void *, dlopen, const char *path, int mode) {
	if (path != NULL &&
		(hasPrefix(path, "/Library/MobileSubstrate/DynamicLibraries") || hasPrefix(path, "/usr/lib/TweakInject")) &&
		strcmp(path, "/Library/MobileSubstrate/DynamicLibraries/mrybootstrap.dylib") != 0 &&
		strcmp(path, "/usr/lib/TweakInject/mrybootstrap.dylib") != 0) {
		os_log(OS_LOG_DEFAULT, "JetsamFix: Loading of %{public}s was blocked.", path);
		RLog(@"JetsamFix: Loading of %@ was blocked.", path); // DEBUG
		return NULL;
	}
	return %orig;
}
