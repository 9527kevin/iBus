//
//  StationListControllerViewController.m
//  iBus-iPhone
//
//  Created by yanghua on 5/25/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "StationListController.h"

@interface StationListController ()

@end

@implementation StationListController

- (void)dealloc{
    [_lineId release],_lineId=nil;
    
    [super dealloc];
}

- (id)initWithRefreshHeaderViewEnabled:(BOOL)enableRefreshHeaderView andLoadMoreFooterViewEnabled:(BOOL)enableLoadMoreFooterView andTableViewFrame:(CGRect)frame{
    self=[super initWithRefreshHeaderViewEnabled:enableRefreshHeaderView andLoadMoreFooterViewEnabled:enableLoadMoreFooterView];
    if (self) {
        self.tableViewFrame=frame;
    }
    
    return self;
}

- (void)loadView{
    self.view=[[[UIView alloc] initWithFrame:Default_Frame_WithoutStatusBar] autorelease];
    self.view.backgroundColor=[UIColor whiteColor];
    
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self sendRequest4StationList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods -
- (void)sendRequest4StationList{
    NSURL *requestUrl=[NSURL URLWithString:[NSString stringWithFormat:Url_DetailOfLine,self.lineId,@"1"]];
    __block ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:requestUrl];
    [request setCompletionBlock:^{
        
    }];
    
}

- (void)initBlocks{
    [super initBlocks];
    
    
}

@end
