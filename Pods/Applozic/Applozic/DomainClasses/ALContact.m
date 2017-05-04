//
//  ALContact.m
//  ChatApp
//
//  Created by shaik riyaz on 15/08/15.
//  Copyright (c) 2015 AppLogic. All rights reserved.
//

#import "ALContact.h"

@implementation ALContact



-(instancetype)initWithDict:(NSDictionary * ) dictionary {
    self = [super init];
    [self populateDataFromDictonary:dictionary];
    return self;
    
}

-(void)populateDataFromDictonary:(NSDictionary *)dict
{
    self.userId = [dict objectForKey:@"userId"];
    self.fullName = [dict objectForKey:@"fullName"];
    self.contactNumber = [dict objectForKey:@"contactNumber"];
    self.displayName = [dict objectForKey:@"displayName"];
    self.contactImageUrl = [dict objectForKey:@"contactImageUrl"];
    self.email = [dict objectForKey:@"email"];
    self.localImageResourceName = [dict objectForKey:@"localImageResourceName"];
    self.applicationId = [dict objectForKey:@"applicationId"];
    self.lastSeenAt = [dict objectForKey:@"lastSeenAtTime"];
//    self.connected = [dict objectForKey:@"connected"];
     self.connected = [[dict valueForKey:@"connected"] boolValue];
    self.unreadCount = [dict objectForKey:@"unreadCount"];
    self.userStatus = [dict objectForKey:@"statusMessage"];
}

-(NSString *)getDisplayName
{
    NSString * trimDisplayName = [self.displayName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString * trimFullName = [self.fullName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if(self.displayName && trimDisplayName.length)
    {
        return self.displayName;
    }
    else if (self.fullName && trimFullName.length)
    {
        return self.fullName;
    }
    else
    {
        return self.userId;
    }
    
}

@end
