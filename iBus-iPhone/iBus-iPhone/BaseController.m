//
//  BaseController.m
//  iBus-iPhone
//
//  Created by yanghua on 5/19/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "BaseController.h"

@interface BaseController ()

@end

@implementation BaseController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

- (void)initNavigationController{
    if ([self.navigationController.parentViewController respondsToSelector:@selector(revealGesture:)] && [self.navigationController.parentViewController respondsToSelector:@selector(revealToggle:)])
	{
		UIPanGestureRecognizer *navigationBarPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self.navigationController.parentViewController
                                                                                                            action:@selector(revealGesture:)];
		[self.navigationController.navigationBar addGestureRecognizer:navigationBarPanGestureRecognizer];
		
        //left bar button item
        UIButton *menuBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [menuBtn setBackgroundImage:[UIImage imageNamed:@"menuBtn.png"] forState:UIControlStateNormal];
        menuBtn.frame=CGRectMake(0, 0, 30.0f, 30.0f);
        [menuBtn addTarget:self.navigationController.parentViewController
                    action:@selector(revealToggle:)
          forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *menuBarBtn=[[[UIBarButtonItem alloc]initWithCustomView:menuBtn] autorelease];
        self.navigationItem.leftBarButtonItem=menuBarBtn;
	}
}

- (void)initNavLeftBackButton{
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(0, 0, 30, 30);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"backBtn.png"]
                       forState:UIControlStateNormal];
    [backBtn addTarget:self
                action:@selector(handleBack:)
      forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBarBtnItem=[[[UIBarButtonItem alloc] initWithCustomView:backBtn] autorelease];
    
    self.navigationItem.leftBarButtonItem = backBarBtnItem;
}

- (void)handleBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initNavRightBarButton{
    
}

- (void)handleRightBarButton:(id)sender{
    
}

@end
