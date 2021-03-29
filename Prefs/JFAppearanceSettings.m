#import "JFRootListController.h"

@implementation JFAppearanceSettings

- (UIColor *)tintColor {
    return [UIColor systemBlueColor];
}

- (UIColor *)statusBarTintColor {
    return [UIColor whiteColor];
}

- (UIColor *)navigationBarTitleColor {
    return [UIColor whiteColor];
}

- (UIColor *)navigationBarTintColor {
    return [UIColor whiteColor];
}

- (UIColor *)tableViewCellSeparatorColor {
    return [UIColor colorWithWhite:0 alpha:0]; // transparent
}

- (UIColor *)navigationBarBackgroundColor {
    return [UIColor systemBlueColor];
}

- (BOOL)translucentNavigationBar {
    return YES;
}

@end
