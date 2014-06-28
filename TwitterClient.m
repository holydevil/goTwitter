//
//  TwitterClient.m
//  goTwitter
//
//  Created by Praveen P N on 6/27/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

#import "TwitterClient.h"

@implementation TwitterClient

+(TwitterClient *) instance {
    static TwitterClient *instance = nil;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.twitter.com"] consumerKey:@"7xNcIPMJ0sHNJrvoYFYG6Q5MI" consumerSecret:@"yscPMvZEbrnxT1MFWQfN9P9yGDtajFQxTJN11kWBpX9xWQPkAq"];
    });
    
    return instance;
}

-(void)login {
    [self.requestSerializer removeAccessToken];
    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"POST" callbackURL:[NSURL URLWithString:@"gotwitter://oauth"] scope:nil success:^(BDBOAuthToken *requestToken) {
        NSLog(@"Got the request token");
        NSString *authURL = [NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:authURL]];
    } failure:^(NSError *error) {
        NSLog(@"failure");
    }];
}

-(AFHTTPRequestOperation *) getHomeTimelineWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    return [self GET:@"1.1/statuses/home_timeline.json" parameters:nil success:success failure:failure];
}

@end
