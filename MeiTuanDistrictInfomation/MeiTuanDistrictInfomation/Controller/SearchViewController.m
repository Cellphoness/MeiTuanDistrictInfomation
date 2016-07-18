//
//  SearchViewController.m
//  Lesson_15_homework_meituan
//
//  Created by lanou on 16/4/23.
//  Copyright © 2016年 FJX. All rights reserved.
//

#import "SearchViewController.h"
#import "CityModel.h"

@interface SearchViewController () <UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SearchViewController

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.searchController.active)
    {
        return self.searchList.count;
    }
    else
    {
        return self.dataArray.count;

    }
}

-(void)initSearvhController
{
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    self.searchController.searchBar.placeholder= @"城市/行政区/拼音";
    self.tableView.tableHeaderView = self.searchController.searchBar;
}

//-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
//{
//    // 谓词的包含语法,之前文章介绍过http://www.cnblogs.com/xiaofeixiang/
//    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
//    if (self.searchList!= nil) {
//        [self.searchList removeAllObjects];
//    }
//    //过滤数据
//    self.searchList= [NSMutableArray arrayWithArray:[_dataArray filteredArrayUsingPredicate:preicate]];
//    //刷新表格
//    return YES;
//}

-(BOOL)IsChinese:(NSString *)str
{
    for(int i=0; i< [str length];i++)
    {
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
    }
    return NO;
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = [self.searchController.searchBar text];
    //将输入的数据统一变成拼音再过滤
    if ([self IsChinese:searchString])
    {
        NSMutableString *pinyin = [[NSMutableString alloc] initWithString:searchString];
        CFStringTransform((__bridge CFMutableStringRef)pinyin, 0, kCFStringTransformMandarinLatin, NO);
        CFStringTransform((__bridge CFMutableStringRef)pinyin, 0, kCFStringTransformStripDiacritics, NO);
        searchString = pinyin;
    }
    
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    if (self.searchList!= nil) {
        [self.searchList removeAllObjects];
    }
    //过滤数据
    self.searchList= [NSMutableArray arrayWithArray:[self.searchPinyin filteredArrayUsingPredicate:preicate]];
    //变回汉字数组
    self.searchList = [self transfromArray:self.searchList];
    
    //刷新表格
    [self.tableView reloadData];
}

//拼音变回汉字
-(NSString *)transfromToHan:(NSString *)pinyin
{
    for (CityModel *model in self.array)
    {
        if ([model.pinyinForCity isEqualToString:pinyin])
        {
            return model.city;
        }
    }
    return nil;
}
//拼音数组变回汉字数组
-(NSMutableArray *)transfromArray:(NSArray *)array
{
    NSMutableArray *mutArray = [[NSMutableArray alloc] init];
    for (id object in array)
    {
        [mutArray addObject:[self transfromToHan:object]];
    }
    return mutArray;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"city"];
    
//    cell.textLabel.text = model.city;
    if (self.searchController.active)
    {
        cell.textLabel.text = self.searchList[indexPath.row];
    }
    else
    {
        cell.textLabel.text = self.dataArray[indexPath.row];
    }
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self initSearvhController];
    // Do any additional setup after loading the view from its nib.
}

-(void)loadData
{
    NSMutableArray *arrayHan = [[NSMutableArray alloc] init];
    NSMutableArray *arrayPinyin = [[NSMutableArray alloc] init];
    
    for (CityModel *model in self.dataArray)
    {
        [arrayHan addObject:model.city];
        [arrayPinyin addObject:model.pinyinForCity];
    }
    self.array = [[NSMutableArray alloc] initWithArray:self.dataArray];
    
    self.dataArray = arrayHan;
    self.searchPinyin = arrayPinyin;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.searchController.searchBar resignFirstResponder];
}

//-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
//{
////    searchBar.showsCancelButton = YES;
//}
//
//-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
//{
////    searchBar.showsCancelButton = NO;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
