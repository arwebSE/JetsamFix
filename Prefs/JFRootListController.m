#include "JFRootListController.h"
#import "../Tweak/Tweak.h"

BOOL enabled = NO;

@implementation JFRootListController

- (instancetype)init {

    self = [super init];

    if (self) {
        self.enableSwitch = [[UISwitch alloc] init];
    }
    
    return self;
}

@end
