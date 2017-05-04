//
//  ViewController.h
//  ChatApp
//
//  Copyright (c) 2015 AppLozic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALChatViewController.h"
#import "ALContactCell.h"
#import "ALNewContactsViewController.h"

@protocol ALMessagesViewDelegate <NSObject>

@optional

-(void)handleCustomActionFromMsgVC:(UIViewController *)chatView andWithMessage:(ALMessage *)alMessage;

@end

@interface ALMessagesViewController : UIViewController <ALChatViewControllerDelegate>

@property (nonatomic, strong) id <ALMessagesViewDelegate> messagesViewDelegate;

@property(nonatomic,strong) ALChatViewController * detailChatViewController;

-(void)createDetailChatViewController: (NSString *) contactIds;

-(void) syncCall:(ALMessage *) alMessage andMessageList:(NSMutableArray *)messageArray;

-(void)pushNotificationhandler:(NSNotification *) notification;

-(void)displayAttachmentMediaType:(ALMessage *)message andContactCell:(ALContactCell *)contactCell;

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

-(UIView *)setCustomBackButton:(NSString *)text;

-(void)createAndLaunchChatView;

-(void) callLastSeenStatusUpdate;

@property (strong, nonatomic) NSString * userIdToLaunch;
@property (strong, nonatomic) NSNumber *channelKey;
@property (strong, nonatomic) NSNumber * conversationId;

-(void)insertChannelMessage:(NSNumber *)channelKey;

/*****************
 SUB_GROUP LAUNCH
*****************/

@property (strong, nonatomic) NSNumber *parentGroupKey;
@property (strong, nonatomic) NSMutableArray *childGroupList;
-(void)intializeSubgroupMessages;

@end

