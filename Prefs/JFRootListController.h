#import <UIKit/UIKit.h>
#import <Cephei/HBPreferences.h>
#import <CepheiPrefs/HBRootListController.h>
#import <CepheiPrefs/HBRootListController.h>
#import <CepheiPrefs/HBAppearanceSettings.h>
#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSControlTableCell.h>
#import <Preferences/PSEditableTableCell.h>

@interface JFAppearanceSettings : HBAppearanceSettings
@end

@interface JFRootListController : HBRootListController {
    UITableView * _table;
}
@property (nonatomic, retain) UISwitch* enableSwitch;
@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIImageView *iconView;
@property (nonatomic, retain) UIBlurEffect* blur;
@property (nonatomic, retain) UIVisualEffectView* blurView;
- (void)toggleState;
- (void)setEnableSwitchState;
- (void)respring;
- (void)setCellForRowAtIndexPath:(NSIndexPath *)indexPath enabled:(BOOL)enabled;
@end

@interface PSEditableTableCell (Interface)
- (id)textField;
@end
