//
//  MenuContainer.m
//  iBus-iPhone
//
//  Created by yanghua on 5/19/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "MenuContainerController.h"

@interface MenuContainerController ()

//menu buttons
@property (nonatomic,retain) UIButton *busSearchBtn;
@property (nonatomic,retain) UIButton *myBusZoomBtn;

@end

@implementation MenuContainerController

- (void)dealloc{
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView{
    self.view=[UIView alloc] initWithFrame:<#(CGRect)#>
    [self initMenuContainer];
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

#pragma mark - private methods -


- (void)initMenuContainer{
    UIView *menuContainerView=[[UIView alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)]
}

#pragma mark - button events -
//- (void)

@end
