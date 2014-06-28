//
//  TwitterClient.h
//  goTwitter
//
//  Created by Praveen P N on 6/27/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager

+(TwitterClient *) instance;

-(void)login;
-(AFHTTPRequestOperation *) getHomeTimelineWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;



@end
