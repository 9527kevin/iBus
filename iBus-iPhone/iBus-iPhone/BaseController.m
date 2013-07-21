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

- (void)dealloc{
    [Default_Notification_Center removeObserver:self
                                           name:Notification_For_ThemeChanged
                                         object:nil];
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}


- (id)init{
    if (self=[super init]) {
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configUIAppearance];
    [self registerThemeChangedNotification];
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
    
    if (self.navigationController.revealController.type & PKRevealControllerTypeLeft)
    {
        //left bar button item
        UIButton *menuBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [menuBtn setBackgroundImage:[UIImage imageNamed:@"menuBtn.png"] forState:UIControlStateNormal];
        menuBtn.frame=CGRectMake(0, 0, 30.0f, 30.0f);
        [menuBtn addTarget:self
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

- (void)revealToggle:(id)sender{
    if (self.navigationController.revealController.focusedController == self.navigationController.revealController.leftViewController)
    {
        [self.navigationController.revealController showViewController:self.navigationController.revealController.frontViewController];
    }
    else
    {
        [self.navigationController.revealController showViewController:self.navigationController.revealController.leftViewController];
    }
}

- (void)configUIAppearance{
    NSLog(@"base config ui ");
}

#pragma mark - theme changed notification -
- (void)registerThemeChangedNotification{
    [Default_Notification_Center addObserver:self
                                    selector:@selector(handleThemeChangedNotification:)
                                        name:Notification_For_ThemeChanged
                                      object:nil];
}

- (void)handleThemeChangedNotification:(NSNotification*)notification{
    UIImage *navBarBackgroundImg=[[[ThemeManager sharedInstance] themedImageWithName:@"themeColor.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0.0f, 0.0f, 1.0f, 1.0f)
                                                                                                                       resizingMode:UIImageResizingModeTile];
    
    [self.navigationController.navigationBar setBackgroundImage:navBarBackgroundImg
                                                  forBarMetrics:UIBarMetricsDefault];
    [self configUIAppearance];
}

@end
