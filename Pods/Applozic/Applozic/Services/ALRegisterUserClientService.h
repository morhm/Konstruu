//
//  ALRegisterUserClientService.h
//  ChatApp
//
//  Created by devashish on 18/09/2015.
//  Copyright (c) 2015 AppLogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALRegistrationResponse.h"
#import "ALUser.h"
#import "ALConstant.h"


@interface ALRegisterUserClientService : NSObject

-(void) initWithCompletion:(ALUser *)user withCompletion:(void(^)(ALRegistrationResponse * message, NSError * error)) completion;

-(void) updateApnDeviceTokenWithCompletion:(NSString *)apnDeviceToken withCompletion:(void(^)(ALRegistrationResponse * message, NSError * error)) completion;

+(void) updateNotificationMode:(short)notificationMode withCompletion:(void(^)(ALRegistrationResponse * response, NSError *error)) completion;
-(void) connect;

-(void) disconnect;

-(void)logoutWithCompletionHandler:(void(^)())completion;

+(BOOL)isAppUpdated;

-(void)syncAccountStatus;

@end
