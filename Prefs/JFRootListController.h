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
@property (nonatomic, retain) UIImageView *headerImageView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIImageView *iconView;
- (void)toggleState;
- (void)setEnableSwitchState;
- (void)respring;
- (void)respringUtil;
- (void)setCellForRowAtIndexPath:(NSIndexPath *)indexPath enabled:(BOOL)enabled;
@end

@interface PSEditableTableCell (Interface)
- (id)textField;
@end
