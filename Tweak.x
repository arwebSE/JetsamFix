#import <dlfcn.h>
#import <os/log.h>
#import <string.h>

#define hasPrefix(string, prefix) (strncmp(prefix, string, strlen(prefix)) == 0) // Credits: KritantaDev

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
