//
//  LineListController.m
//  iBus-iPhone
//
//  Created by yanghua on 5/25/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "LineListController.h"

@interface LineListController ()

@end

@implementation LineListController

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
    
	[self initBlocks];
    [self.tableView reloadData];
    self.tableView.hidden=YES;
    
    [self sendRequest4LineList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods -
- (void)sendRequest4LineList{
//    __block ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:Url_BusLineList];
//    
//    [request setCompletionBlock:^{
//        NSData *responseData = [request responseData];
//        
//        NSDictionary *responseDic=[NSJSONSerialization JSONObjectWithData:responseData
//                                                                  options:NSJSONReadingAllowFragments
//                                                                    error:nil];
//        
//        //success
//        if ([responseDic[@"statusCode"] isEqualToString:@"OK"]) {
//            self.dataSource=responseDic[@"data"];
//            
//            self.tableView.hidden=NO;
//            [self.tableView reloadData];
//            
//        }
//    }];
}

- (void)initBlocks{
    [super initBlocks];
    
    
}

@end
