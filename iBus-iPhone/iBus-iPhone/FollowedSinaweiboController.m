//
//  FollowedSinaweiboController.m
//  iBus-iPhone
//
//  Created by yanghua on 6/22/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "FollowedSinaweiboController.h"
#import "RelationshipCell.h"

static NSString *cellIdentifierForRelation=@"cellIdentifierForRelation";

#define API_friendships_friends            @"friendships/friends.json"

@interface FollowedSinaweiboController ()

@property (nonatomic,retain) SinaWeibo *sinaWeiboManager;
@property (nonatomic,assign) int nextCursor;

@end

@implementation FollowedSinaweiboController

- (void)dealloc{
    [_userGroupedDictionary release],_userGroupedDictionary=nil;
    [_allIndexCharacter release],_allIndexCharacter=nil;
    [_sinaWeiboManager release],_sinaWeiboManager=nil;
    
    [super dealloc];
}

- (id)initWithRefreshHeaderViewEnabled:(BOOL)enableRefreshHeaderView
          andLoadMoreFooterViewEnabled:(BOOL)enableLoadMoreFooterView
                     andTableViewFrame:(CGRect)frame{
    self=[super initWithRefreshHeaderViewEnabled:enableRefreshHeaderView
                    andLoadMoreFooterViewEnabled:enableLoadMoreFooterView
                               andTableViewFrame:frame];
    
    if (self) {
        self.tableViewFrame=frame;
        self.nextCursor=0;
    }
    
    return self;
}

- (void)loadView{
    self.view=[[[UIView alloc] initWithFrame:Default_Frame_WithoutStatusBar] autorelease];
    self.view.backgroundColor=Default_TableView_BackgroundColor;
    self.navigationItem.title=@"关注的人";
    
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavLeftBackButton];
    [self initSinaweiboManager];
    
    if (!self.sinaWeiboManager.isLoggedIn) {
        return;
    }
    
    [self initBlocks];
    [self sendRequest4GetFollowedListWithCursor:0];
    
    self.tableView.hidden=YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    //release data source
    self.nextCursor=0;
    self.dataSource=nil;
    [self sendRequest4GetFollowedListWithCursor:0];
}

- (void)initNavLeftBackButton{
    UIButton *btn=[UIButton initButtonInstanceWithType:UIButtonTypeCustom
                                                 frame:CGRectMake(0, 0, 30, 30)
                                               imgName:@"closeBtn.png"
                                           eventTarget:self
                                           touchUpFunc:@selector(closeButton_touchUpInside)
                                         touchDownFunc:nil];
	
	UIBarButtonItem *backBarItem=[[UIBarButtonItem alloc]initWithCustomView:btn];
	self.navigationItem.leftBarButtonItem=backBarItem;
	[backBarItem release];
}

-(void)closeButton_touchUpInside{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - private methods -
- (void)sendRequest4GetFollowedListWithCursor:(int)cursor{
    NSMutableDictionary *requestParms=[NSMutableDictionary dictionary];
    requestParms[@"access_token"]=self.sinaWeiboManager.accessToken;
    requestParms[@"uid"]=self.sinaWeiboManager.userID;
    requestParms[@"cursor"]=[NSString stringWithFormat:@"%d",cursor];
    
    [self.sinaWeiboManager requestWithURL:API_friendships_friends
                                   params:requestParms
                               httpMethod:HTTP_METHOD_GET
                                 delegate:self];
    
    self.imageDownloadsInProgress=[NSMutableDictionary dictionary];
    self.imageDownloadedInstances=[NSMutableDictionary dictionary];
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
}

- (void)initBlocks{
    [super initBlocks];
    
    __block FollowedSinaweiboController *blockedSelf=self;
    
    self.cellForRowAtIndexPathDelegate=^(UITableView *tableView, NSIndexPath *indexPath){
        //get the section by index
        NSString *currentIndexStr=[self.allIndexCharacter objectAtIndex:indexPath.section];
        NSArray *currentSectionDataSource=[self.userGroupedDictionary objectForKey:currentIndexStr];
        
        NSDictionary *currentUserInfo=currentSectionDataSource[indexPath.row];
        UIImage *currentHeadImg=(UIImage*)self.imageDownloadedInstances[indexPath];
        
        
        RelationshipCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierForRelation];
        if (cell==nil) {
            cell=[[[RelationshipCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:cellIdentifierForRelation] autorelease];
        }
        
        cell.nickName=currentUserInfo[@"screen_name"];
        
        if(!currentHeadImg){
            cell.headImgView.image=[UIImage imageNamed:@"iconPlaceHolder.png"];
            if (self.tableView.dragging==NO&&self.tableView.decelerating==NO) {
                [self startIconDownload:currentUserInfo[@"profile_image_url"] forIndexPath:indexPath withSize:Default_HeadImg_Size];
            }
        }else{
            cell.headImgView.image=currentHeadImg;
        }
        
        return cell;
    };
    
    self.heightForRowAtIndexPathDelegate=^(UITableView *tableView,NSIndexPath *indexPath){
        return 40.0f;
    };
    
    self.didSelectRowAtIndexPathDelegate=^(UITableView *tableView, NSIndexPath *indexPath){
        [self tableView:tableView didSelectRowAtIndexPath:indexPath];
    };
    
    self.loadImagesForVisiableRowsFunc=^(){
        if ([self.dataSource count]>0) {
            //取得当前tableview中的可见cell集合
            NSArray *visiblePaths=[self.tableView indexPathsForVisibleRows];
            for (NSIndexPath *indexPath in visiblePaths) {
                
                UIImage *tmpImg=(UIImage*)self.imageDownloadedInstances[indexPath];
                
                NSString *currentIndexStr=[self.allIndexCharacter objectAtIndex:indexPath.section];
                NSArray *currentSectionDataSource=[self.userGroupedDictionary objectForKey:currentIndexStr];
                
                NSDictionary *userInfo=[currentSectionDataSource objectAtIndex:indexPath.row];
                if (!tmpImg) {
                    [self startIconDownload:userInfo[@"profile_image_url"]
                               forIndexPath:indexPath withSize:Default_HeadImg_Size];
                }
            }
        }
    };
    
    self.appImageDownloadCompleted=^(NSIndexPath *indexPath){
        RelationshipCell *cell=(RelationshipCell*)[self.tableView cellForRowAtIndexPath:indexPath];
        IconDownloader *iconDownloader=nil;
        iconDownloader=[self.imageDownloadsInProgress objectForKey:indexPath];
        if (iconDownloader) {
            [self.imageDownloadedInstances setObject:iconDownloader.appIcon forKey:indexPath];
            cell.headImgView.image=iconDownloader.appIcon;
        }
    };
    
    //load more
    self.loadMoreDataSourceFunc=^{
        //no more records
        if (self.nextCursor==0) {
            [SVProgressHUD showErrorWithStatus:@"关注的人已全部加载!"];
            return ;
        }
        
        //send request to get next page
        [self sendRequest4GetFollowedListWithCursor:self.nextCursor];
        blockedSelf.isLoadingMore=YES;
    };
    
    self.loadMoreDataSourceCompleted=^{
        blockedSelf.isLoadingMore=NO;
        [blockedSelf.loadMoreFooterView loadMoreScrollViewDataSourceDidFinishedLoading:
         blockedSelf.tableView];
    };

}

- (void)initSinaweiboManager{
    _sinaWeiboManager=[[SinaWeibo alloc] initWithAppKey:kAppKey
                                              appSecret:kAppSecret
                                         appRedirectURI:kAppRedirectURI
                                            andDelegate:self];
    
    //exists login info
    NSDictionary *sinaweiboInfo = [UserDefault objectForKey:@"SinaWeiboAuthData"];
    if (sinaweiboInfo[@"AccessTokenKey"] && sinaweiboInfo[@"ExpirationDateKey"]
        && sinaweiboInfo[@"UserIDKey"])
    {
        self.sinaWeiboManager.accessToken = sinaweiboInfo[@"AccessTokenKey"];
        self.sinaWeiboManager.expirationDate = sinaweiboInfo[@"ExpirationDateKey"];
        self.sinaWeiboManager.userID = sinaweiboInfo[@"UserIDKey"];
    }
}

#pragma mark - other UITableView delegate
//用于分组与索引
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	NSArray *sectionDataSource=
    [self.userGroupedDictionary objectForKey:[self.allIndexCharacter objectAtIndex:section]];
    
    return [sectionDataSource count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.allIndexCharacter count];
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.allIndexCharacter objectAtIndex:section];
}

- (NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSMutableArray *result = [[[NSMutableArray alloc]init] autorelease];
    
    for(char c = 'A';c<='Z';c++)
        [result addObject:[NSString stringWithFormat:@"%c",c]];
    
    return result;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    NSInteger sectionIndex=0;
    for (NSString *indexCharStr in self.allIndexCharacter) {
        if ([title isEqualToString:indexCharStr]) {
            return sectionIndex;
        }
        sectionIndex++;
    }
    
    return sectionIndex;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *currentIndexStr=[self.allIndexCharacter objectAtIndex:indexPath.section];
    NSArray *currentSectionDataSource=[self.userGroupedDictionary objectForKey:currentIndexStr];
    NSDictionary *currentUserInfo=currentSectionDataSource[indexPath.row];
    
    NSDictionary *commonUserInfo=[NSDictionary dictionaryWithObjectsAndKeys:currentUserInfo[@"screen_name"],@"userName", nil];
    
    [self dismissViewControllerAnimated:YES completion:^{
        //when selected a followed, post a notification to notification center
        [Default_Notification_Center postNotificationName:Notification_For_AtSomebody
                                                   object:commonUserInfo
                                                 userInfo:nil];
    }];
}

#pragma mark - search index -
- (void)handleDataSourceAndGenerateGroupedUserSet{
    if (!self.dataSource||[self.dataSource count]==0) {
        return;
    }
    [self generateIndex];
    [self groupUserSet];
}

//生成索引
- (void)generateIndex{
    NSMutableArray *tmpAllIndexCharacter=[[NSMutableArray alloc]init];
    for (int i=0; i<self.dataSource.count; i++) {
        NSDictionary *userInfo=self.dataSource[i];
        BOOL isChinese=[GlobalInstance isChineseCharacter:[userInfo[@"screen_name"] characterAtIndex:0]];
        NSString *firstString=@"#";
        if (isChinese) {
            char firstChar=pinyinFirstLetter([userInfo[@"screen_name"] characterAtIndex:0]);
            firstString=[NSString stringWithFormat:@"%c",firstChar];
        }else{
            firstString=[userInfo[@"screen_name"] substringWithRange:NSMakeRange(0, 1)];
        }
        
        if (![tmpAllIndexCharacter containsObject:[firstString uppercaseString]]) {
            [tmpAllIndexCharacter addObject:[firstString uppercaseString]];
        }
    }
    self.allIndexCharacter=tmpAllIndexCharacter;
    [tmpAllIndexCharacter release];
    
    //sort
    [self.allIndexCharacter sortUsingSelector:@selector(compare:)];
}

//分组用户集合
- (void)groupUserSet{
    NSMutableDictionary *tmpUserGroupedSet=[[NSMutableDictionary alloc]init];
    for (NSString *sectionString in self.allIndexCharacter) {
        NSMutableArray *sectionDataSource=[[NSMutableArray alloc]init];
        for (NSDictionary *userItem in self.dataSource) {
            BOOL isChinese=[GlobalInstance isChineseCharacter:[userItem[@"screen_name"] characterAtIndex:0]];
            NSString *firstString=@"#";
            if (isChinese) {
                char firstChar=pinyinFirstLetter([userItem[@"screen_name"] characterAtIndex:0]);
                firstString=[NSString stringWithFormat:@"%c",firstChar];
            }else{
                firstString=[userItem[@"screen_name"] substringWithRange:NSMakeRange(0, 1)];
            }
            
            if ([sectionString isEqualToString:[firstString uppercaseString]]) {
                [sectionDataSource addObject:userItem];
            }
        }
        [tmpUserGroupedSet setValue:sectionDataSource forKey:sectionString];
        [sectionDataSource release];
    }
    self.userGroupedDictionary=tmpUserGroupedSet;
    [tmpUserGroupedSet release];
}

#pragma mark - sina weibo delegate -
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:@"获取用户关注的人失败！"];
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
    [SVProgressHUD dismiss];
    if ([request.url hasSuffix:API_friendships_friends]){
        NSDictionary *resultDic=(NSDictionary*)result;
        int next_cursor=[resultDic[@"next_cursor"] intValue];
        NSArray *tmpArr=resultDic[@"users"];
        
        //union to data source
        if (!self.dataSource) {
            self.dataSource=[NSMutableArray arrayWithArray:tmpArr];
        }else if(self.dataSource && self.nextCursor!=next_cursor){
            [self.dataSource addObjectsFromArray:tmpArr];
        }
        
        self.nextCursor=next_cursor;
    }
    
    if (self.dataSource && self.dataSource.count>0) {
        [self handleDataSourceAndGenerateGroupedUserSet];       //generate index
        self.tableView.hidden=NO;
        [self.tableView reloadData];
    }
}


@end
