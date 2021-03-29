#import <UIKit/UIKit.h>
#import <CepheiPrefs/HBRootListController.h>
#import <Cephei/HBPreferences.h>

@interface JFRootListController : HBRootListController {
    UITableView * _table;
}
@property(nonatomic, retain)UISwitch* enableSwitch;

@end
