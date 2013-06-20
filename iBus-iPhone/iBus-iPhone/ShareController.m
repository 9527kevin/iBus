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

- (void)loadView{
    self.view=[[[UIView alloc] initWithFrame:Default_Frame_WithoutStatusBar] autorelease];
    self.view.backgroundColor=Default_TableView_BackgroundColor;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
