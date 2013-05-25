//
//  BusQueryController.m
//  iBus-iPhone
//
//  Created by yanghua on 5/20/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "BusQueryController.h"

@interface BusQueryController ()

@end

@implementation BusQueryController

- (void)loadView{
    self.view=[[[UIView alloc] initWithFrame:Default_Frame_WithoutStatusBar] autorelease];
    self.view.backgroundColor=[UIColor whiteColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	[self initNavigationController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods -
- (void)initNavigationController{
    if ([self.navigationController.parentViewController respondsToSelector:@selector(revealGesture:)] && [self.navigationController.parentViewController respondsToSelector:@selector(revealToggle:)])
	{
		UIPanGestureRecognizer *navigationBarPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self.navigationController.parentViewController
                                                                                                            action:@selector(revealGesture:)];
		[self.navigationController.navigationBar addGestureRecognizer:navigationBarPanGestureRecognizer];
		
		self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"导航菜单"
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self.navigationController.parentViewController
                                                                                action:@selector(revealToggle:)];
        
        self.navigationItem.title=@"公交查询";
	}
}

@end
