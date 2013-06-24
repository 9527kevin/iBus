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

@interface FollowedSinaweiboController ()

@end

@implementation FollowedSinaweiboController

- (void)dealloc{
    [_userGroupedDictionary release],_userGroupedDictionary=nil;
    [_allIndexCharacter release],_allIndexCharacter=nil;
    
    [super dealloc];
}

- (id)initWithRefreshHeaderViewEnabled:(BOOL)enableRefreshHeaderView
          andLoadMoreFooterViewEnabled:(BOOL)enableLoadMoreFooterView
                     andTableViewFrame:(CGRect)frame{
    self=[super initWithRefreshHeaderViewEnabled:enableRefreshHeaderView andLoadMoreFooterViewEnabled:enableLoadMoreFooterView andTableViewFrame:frame];
    
    if (self) {
        self.tableViewFrame=frame;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initBlocks];
    [self.tableView reloadData];
    self.tableView.hidden=YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
            NSString *currentIndexStr=[self.allIndexCharacter objectAtIndex:indexPath.section];
            NSArray *currentSectionDataSource=[self.userGroupedDictionary objectForKey:currentIndexStr];
            NSDictionary *currentUserInfo=currentSectionDataSource[indexPath.row];
            
            
            [self dismissViewControllerAnimated:YES completion:^{
                //when selected a followed, post a notification to notification center
                [Default_Notification_Center postNotificationName:Notification_For_AtSomebody
                                                           object:currentUserInfo
                                                         userInfo:nil];
            }];
}

#pragma mark - override methods -
- (void)layoutSubViews{    
    self.view=[[[UIView alloc] initWithFrame:Default_TableView_Frame] autorelease];
    self.view.backgroundColor=[UIColor whiteColor];
}

- (void)initBlocks{
    [super initBlocks];
    
    self.cellForRowAtIndexPathDelegate=^(UITableView *tableView, NSIndexPath *indexPath){
        //get the section by index
        NSString *currentIndexStr=[self.allIndexCharacter objectAtIndex:indexPath.section];
        NSArray *currentSectionDataSource=[self.userGroupedDictionary objectForKey:currentIndexStr];
        
        NSDictionary *currentUserInfo=currentSectionDataSource[indexPath.row];
        UIImage *currentHeadImg=(UIImage*)self.imageDownloadedInstances[indexPath];
        
        
        RelationshipCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierForRelation];
        if (cell==nil) {
            cell=[[[RelationshipCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierForRelation] autorelease];
        }
        
        cell.nickName=currentUserInfo[@"userName"];
        
        if(!currentHeadImg){
            cell.headImgView.image=[UIImage imageNamed:@"iconPlaceHolder.png"];
            if (self.tableView.dragging==NO&&self.tableView.decelerating==NO) {
                [self startIconDownload:currentUserInfo[@"imgUrl"] forIndexPath:indexPath withSize:Default_HeadImg_Size];
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
                    [self startIconDownload:userInfo[@"imgUrl"] forIndexPath:indexPath withSize:Default_HeadImg_Size];
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
}

#pragma mark - other UITableView delegate
//用于分组与索引
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	NSArray *sectionDataSource=[self.userGroupedDictionary objectForKey:[self.allIndexCharacter objectAtIndex:section]];
    
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
        BOOL isChinese=[GlobalInstance isChineseCharacter:[userInfo[@"userName"] characterAtIndex:0]];
        NSString *firstString=@"#";
        if (isChinese) {
            char firstChar=pinyinFirstLetter([userInfo[@"userName"] characterAtIndex:0]);
            firstString=[NSString stringWithFormat:@"%c",firstChar];
        }else{
            firstString=[userInfo[@"userName"] substringWithRange:NSMakeRange(0, 1)];
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
            BOOL isChinese=[GlobalInstance isChineseCharacter:[userItem[@"userName"] characterAtIndex:0]];
            NSString *firstString=@"#";
            if (isChinese) {
                char firstChar=pinyinFirstLetter([userItem[@"userName"] characterAtIndex:0]);
                firstString=[NSString stringWithFormat:@"%c",firstChar];
            }else{
                firstString=[userItem[@"userName"] substringWithRange:NSMakeRange(0, 1)];
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



@end
