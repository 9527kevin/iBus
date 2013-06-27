//
//  ShareController.m
//  iBus-iPhone
//
//  Created by yanghua on 6/20/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "ShareController.h"


@interface ShareController ()

@end

@implementation ShareController

- (void)dealloc{
    [Default_Notification_Center removeObserver:self
                                           name:Notification_For_AtSomebody
                                         object:nil];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods -
- (void)registerAtNotification{
    [Default_Notification_Center addObserver:self
                                    selector:@selector(handleAtNotification:)
                                        name:Notification_For_AtSomebody
                                      object:nil];
}

- (void)handleAtNotification:(NSNotification*)notification{
    //    NSDictionary *followedInfo=(NSDictionary*)[notification object];
    //    [self.followedList addObject:followed];
    //    self.publishTxtView.text=[NSString stringWithFormat:@"%@ @%@ ",self.publishTxtView.text,followedInfo[@"userName"]];
}

#pragma mark - overriding methods -
- (BOOL)isAuthorized{
    return NO;
}

- (void)login{
    
}

- (void)logout{
    
}

- (void)share{
    
}

@end
