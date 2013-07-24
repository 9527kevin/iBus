//
//  ThemeSettingController.m
//  iBus-iPhone
//
//  Created by yanghua on 7/19/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "ThemeSettingController.h"
#import "ConfigItemDao.h"

#define Tag_Start_Index                             1000

@interface ThemeSettingController ()

@property (nonatomic,retain) NSMutableArray         *themeArr;
@property (nonatomic,assign) int                    currentSelectedIndex;

@end

@implementation ThemeSettingController

- (void)dealloc{
    
    [super dealloc];
}

- (void)loadView{
    self.view=[[[UIView alloc] initWithFrame:Default_Frame_WithoutStatusBar] autorelease];
    self.view.backgroundColor=Default_TableView_BackgroundColor;
    
    self.themeArr=[ConfigItemDao getItemWithCategoryId:@"theme"];
    if (self.themeArr.count==0) {
        return;
    }
    
    int rowCount=  (self.themeArr.count % ColumnCount) !=0 ?
                    ((self.themeArr.count / ColumnCount) + 1) :
                    (self.themeArr.count / ColumnCount);
    
    for (int i=0; i<rowCount; i++) {
        for (int j=0; j<ColumnCount; j++) {
            [self.view addSubview:[self initThemeButtonWithRowIndex:i
                                                     andColumnIndex:j]];
        }
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.navigationItem.title=@"主题设置";
    [self initNavLeftBackButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods -
- (UIButton*)initThemeButtonWithRowIndex:(int)rowIndex
                          andColumnIndex:(int)columnIndex{
    float origin_x=Margin_Left + ThemeChose_Button_Width * columnIndex + Margin_Between * columnIndex;
    float origin_y=Margin_Top + ThemeChose_Button_Height * rowIndex + Margin_Between * rowIndex;
    
    CGRect btnFrame=CGRectMake(origin_x, origin_y, ThemeChose_Button_Width, ThemeChose_Button_Height);
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=btnFrame;
    
    int index=rowIndex * ColumnCount + columnIndex;
    
    UIColor *currentThemeColor=[UIColor parseColorFromStr:((NSDictionary*)self.themeArr[index]).allValues[0]];
    [btn setBackgroundColor:currentThemeColor];
    [btn setBackgroundImage:[UIImage imageNamed:@"cover.png"] forState:UIControlStateSelected];
    
    
    btn.tag=Tag_Start_Index + index;
    
    [btn addTarget:self
            action:@selector(themeButton_touchUpIndise:)
  forControlEvents:UIControlEventTouchUpInside];
    
    //if current theme
    if ([[ThemeManager sharedInstance].themeName isEqualToString:
         ((NSDictionary*)self.themeArr[index]).allKeys[0]]) {
        btn.selected=YES;
        self.currentSelectedIndex=index;
    }
    
    return btn;
}

- (void)themeButton_touchUpIndise:(id)sender{
    //unselect
    UIButton *lastSelectedBtn=(UIButton*)[self.view viewWithTag:(Tag_Start_Index  + self.currentSelectedIndex)];
    lastSelectedBtn.selected=NO;
    
    //select
    UIButton *selectedBtn=(UIButton*)sender;
    self.currentSelectedIndex=selectedBtn.tag - Tag_Start_Index;
    selectedBtn.selected=YES;
    
    [[ThemeManager sharedInstance] changeTheme:((NSDictionary*)self.themeArr[self.currentSelectedIndex]).allKeys[0]];
    
    //post themechanged notification
    [Default_Notification_Center postNotificationName:Notification_For_ThemeChanged
                                               object:nil];
}

@end
