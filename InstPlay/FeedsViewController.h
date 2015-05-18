#import <UIKit/UIKit.h>

@interface FeedsViewController : UITableViewController <
UISplitViewControllerDelegate,
UITableViewDataSource,
UITableViewDelegate>
@property(strong, nonatomic) NSArray *data;

@end
