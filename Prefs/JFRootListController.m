#include "JFRootListController.h"
#import <Cephei/HBRespringController.h>
#import "../Tweak/Tweak.h"

BOOL enabled = YES;

@implementation JFRootListController

- (instancetype)init {

    self = [super init];

    if (self) {
        JFAppearanceSettings* appearanceSettings = [[JFAppearanceSettings alloc] init];
        self.hb_appearanceSettings = appearanceSettings;

        self.enableSwitch = [[UISwitch alloc] init];
        self.enableSwitch.onTintColor = [UIColor systemGreenColor];
        [self.enableSwitch addTarget:self action:@selector(toggleState) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* switchy = [[UIBarButtonItem alloc] initWithCustomView: self.enableSwitch];
        self.navigationItem.rightBarButtonItem = switchy;

        self.navigationItem.titleView = [UIView new];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,10,10)];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.titleLabel.text = @"🎈";
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.navigationItem.titleView addSubview:self.titleLabel];

        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,10,10)];
        self.iconView.contentMode = UIViewContentModeScaleAspectFit;
        self.iconView.image = [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/JFPrefs.bundle/icon@2x.png"];
        self.iconView.translatesAutoresizingMaskIntoConstraints = NO;
        self.iconView.alpha = 0.0;
        [self.navigationItem.titleView addSubview:self.iconView];

        [NSLayoutConstraint activateConstraints:@[
            [self.titleLabel.topAnchor constraintEqualToAnchor:self.navigationItem.titleView.topAnchor],
            [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.navigationItem.titleView.leadingAnchor],
            [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.navigationItem.titleView.trailingAnchor],
            [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.navigationItem.titleView.bottomAnchor],
            [self.iconView.topAnchor constraintEqualToAnchor:self.navigationItem.titleView.topAnchor],
            [self.iconView.leadingAnchor constraintEqualToAnchor:self.navigationItem.titleView.leadingAnchor],
            [self.iconView.trailingAnchor constraintEqualToAnchor:self.navigationItem.titleView.trailingAnchor],
            [self.iconView.bottomAnchor constraintEqualToAnchor:self.navigationItem.titleView.bottomAnchor],
        ]];
    }
    
    return self;
}

-(NSArray *)specifiers {

	if (_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;

}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
    self.blurView = [[UIVisualEffectView alloc] initWithEffect:[self blur]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.tableHeaderView = self.headerView;
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    CGRect frame = self.table.bounds;
    frame.origin.y = -frame.size.height;

    self.navigationController.navigationController.navigationBar.barTintColor = [UIColor systemGrayColor]; //?
    [self.navigationController.navigationController.navigationBar setShadowImage: [UIImage new]];
    self.navigationController.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationController.navigationBar.translucent = YES;

}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];

    [self.navigationController.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}]; //?

    [self setEnableSwitchState];

    if (![[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/AAAAAAjetsamfix.disabled"]) return;
    [[self enableSwitch] setEnabled:NO];

    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"JetsamFix"
	message:@"JetsamFix Preferences disabled due to JetsamFix being disabled with iCleaner Pro"
	preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {

        [[self navigationController] popViewControllerAnimated:YES];

	}];

	[alertController addAction:confirmAction];

	[self presentViewController:alertController animated:YES completion:nil];

}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];

    [self.navigationController.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat offsetY = scrollView.contentOffset.y;

    if (offsetY > 200) {
        [UIView animateWithDuration:0.2 animations:^{
            self.iconView.alpha = 1.0;
            self.titleLabel.alpha = 0.0;
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            self.iconView.alpha = 0.0;
            self.titleLabel.alpha = 1.0;
        }];
    }

    if (offsetY > 0) offsetY = 0;
}

- (void)toggleState {

    [[self enableSwitch] setEnabled:NO];

    NSString* path = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/se.arweb.jfprefs.plist"];
    NSMutableDictionary* dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    NSSet* allKeys = [NSSet setWithArray:[dictionary allKeys]];
    HBPreferences *preferences = [[HBPreferences alloc] initWithIdentifier: @"se.arweb.jfprefs"];

    if (!([[NSFileManager defaultManager] fileExistsAtPath:@"/var/mobile/Library/Preferences/se.arweb.jfprefs.plist"])) {
        enabled = YES;
        [preferences setBool:enabled forKey:@"Enabled"];
        [self respring];
    } else if (!([allKeys containsObject:@"Enabled"])) {
        enabled = YES;
        [preferences setBool:enabled forKey:@"Enabled"];
        [self respring];
    } else if ([[preferences objectForKey:@"Enabled"] isEqual:@(NO)]) {
        enabled = YES;
        [preferences setBool:enabled forKey:@"Enabled"];
        [self respring];
    } else if ([[preferences objectForKey:@"Enabled"] isEqual:@(YES)]) {
        enabled = NO;
        [preferences setBool:enabled forKey:@"Enabled"];
        [self respring];
    }

}

- (void)setEnableSwitchState {

    NSString* path = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/se.arweb.jfprefs.plist"];
    NSMutableDictionary* dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    NSSet* allKeys = [NSSet setWithArray:[dictionary allKeys]];
    HBPreferences* preferences = [[HBPreferences alloc] initWithIdentifier: @"se.arweb.jfprefs"];

    if (!([[NSFileManager defaultManager] fileExistsAtPath:@"/var/mobile/Library/Preferences/se.arweb.jfprefs.plist"]))
        [[self enableSwitch] setOn:NO animated:YES];
    else if (!([allKeys containsObject:@"Enabled"]))
        [[self enableSwitch] setOn:NO animated:YES];
    else if ([[preferences objectForKey:@"Enabled"] isEqual:@(YES)])
        [[self enableSwitch] setOn:YES animated:YES];
    else if ([[preferences objectForKey:@"Enabled"] isEqual:@(NO)])
        [[self enableSwitch] setOn:NO animated:YES];

}

- (void)respring {

    [[self blurView] setFrame:[[self view] bounds]];
    [[self blurView] setAlpha:0.0];
    [[self view] addSubview:[self blurView]];

    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [[self blurView] setAlpha:1.0];
    } completion:^(BOOL finished) {
        if (![[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/shuffle.dylib"])
            [HBRespringController respringAndReturnTo:[NSURL URLWithString:@"prefs:root=JetsamFix"]];
        else
            [HBRespringController respringAndReturnTo:[NSURL URLWithString:@"prefs:root=Tweaks&path=JetsamFix"]];
    }];

}

- (void)setCellForRowAtIndexPath:(NSIndexPath *)indexPath enabled:(BOOL)enabled {
    UITableViewCell *cell = [self tableView:self.table cellForRowAtIndexPath:indexPath];

    if (cell) {
        cell.userInteractionEnabled = enabled;
        cell.textLabel.enabled = enabled;
        cell.detailTextLabel.enabled = enabled;
        if ([cell isKindOfClass:[PSControlTableCell class]]) {
            PSControlTableCell *controlCell = (PSControlTableCell *)cell;
            if (controlCell.control)
                controlCell.control.enabled = enabled;
        } else if ([cell isKindOfClass:[PSEditableTableCell class]]) {
            PSEditableTableCell *editableCell = (PSEditableTableCell *)cell;
            ((UITextField*)[editableCell textField]).alpha = enabled ? 1 : 0.4;
        }
    }
}

@end
