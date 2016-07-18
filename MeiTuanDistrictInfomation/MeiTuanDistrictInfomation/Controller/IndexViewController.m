//
//  IndexViewController.m
//  Lesson_15_homework_meituan
//
//  Created by lanou on 16/4/22.
//  Copyright © 2016年 FJX. All rights reserved.
//

#import "IndexViewController.h"
#import "SearchViewController.h"

#import "CityModel.h"
#import "TableCityCell.h"
#import "SearchCell.h"

@interface IndexViewController () <UITableViewDataSource, UITableViewDelegate, TableCityCellDelegate, UISearchBarDelegate>

@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSArray *captitalLetters;
@property (nonatomic, strong)NSMutableDictionary *dictData;

//@property (nonatomic, strong)NSMutableArray *recentCities;

@end

@implementation IndexViewController

- (void)loadData
{
    self.dataArray = [[NSMutableArray alloc] init];
    NSMutableSet * captitalLetters = [[NSMutableSet alloc] init];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ProvincesAndCities" ofType:@"plist"];
    NSArray *array = [[NSArray alloc] initWithContentsOfFile:path];
    //NSLog(@"%@", array);
    
    for (NSDictionary *dict in array) {
        NSArray *cityArray = dict[@"Cities"];
        for (NSDictionary *city in cityArray) {
            CityModel *model = [[CityModel alloc] init];
            [model setValuesForKeysWithDictionary:city];
            
            //获取拼音
            NSMutableString *pinyin = [[NSMutableString alloc] initWithString:city[@"city"]];
            CFStringTransform((__bridge CFMutableStringRef)pinyin, 0, kCFStringTransformMandarinLatin, NO);
            CFStringTransform((__bridge CFMutableStringRef)pinyin, 0, kCFStringTransformStripDiacritics, NO);
            model.pinyinForCity = pinyin;
            
            //获取首字母大写并加到集合
            [captitalLetters addObject:[[NSString stringWithFormat:@"%C", [model.pinyinForCity characterAtIndex:0]]uppercaseString]];
            [self.dataArray addObject:model];
        }
    }
    //排序
    NSSortDescriptor *des = [NSSortDescriptor sortDescriptorWithKey:@"pinyinForCity" ascending:YES];
    [self.dataArray sortUsingDescriptors:@[des]];
    //NSLog(@"%@", self.dataArray);

    //接受所有字母的集合并排序
    self.captitalLetters = [[NSArray alloc] initWithArray:captitalLetters.allObjects];
    self.captitalLetters = [self.captitalLetters sortedArrayUsingSelector:@selector(compare:)];
    //NSLog(@"%@", self.captitalLetters);
    
    //创建一个字典
    self.dictData = [[NSMutableDictionary alloc]init];
    for (NSString *str in self.captitalLetters)
    {
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for (CityModel *model in self.dataArray)
        {
            if ([[[NSString stringWithFormat:@"%C", [model.pinyinForCity characterAtIndex:0]]uppercaseString] isEqualToString:str]) {
                [tempArray addObject:model];
            }
        }
         [self.dictData setObject:tempArray forKey:str];
    }
    //NSLog(@"%@", self.dictData);
}

-(void)createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorColor = [UIColor blackColor];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuse"];
    [self.tableView registerClass:[SearchCell class] forCellReuseIdentifier:@"search"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section <= 3) {
        return 1;
    }
    else
    {
        NSMutableArray *array = self.dictData[self.captitalLetters[section - 4]];
        return array.count;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.captitalLetters.count + 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section > 3) {
        return 50;
    }
    else if(indexPath.section < 3 && indexPath.section > 0)
        return 50;
    else if(indexPath.section == 3)
        return 200;

    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"search"];
        cell.searchBar.delegate = self;
        //[cell canBecomeFirstResponder];
        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSearchBar)];
//        tap.numberOfTapsRequired = 2;
//        tap.numberOfTouchesRequired = 1;
//        
//        [cell addGestureRecognizer:tap];
        return cell;

    }
    else if (indexPath.section == 1) {
        TableCityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityTable1"];
        if (!cell) {
            cell = [[TableCityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cityTable1" WithdataArray:@[self.currentCity]];
            cell.delegate = self;
        }
        return cell;
    }
    else if (indexPath.section == 2)
    {
        TableCityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityTable2"];
        if (!cell) {
            cell = [[TableCityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cityTable2" WithdataArray:@[@"广州", @"武汉", @"北京"]];
            cell.delegate = self;
        }
        return cell;
    }
    else if (indexPath.section == 3)
    {
        TableCityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityTable3"];
        if (!cell) {
            cell = [[TableCityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cityTable3" WithdataArray:@[@"广州", @"上海", @"深圳", @"天津", @"武汉", @"西安", @"南京", @"杭州", @"成都", @"重庆"]];
             cell.delegate = self;
        }
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        NSString *groupName = self.captitalLetters[indexPath.section - 4];
        NSArray *array = self.dictData[groupName];
        CityModel *model = array[indexPath.row];
        cell.textLabel.text = model.city;
        return cell;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return [NSString stringWithFormat:@"定位城市"];
    }
    else if (section == 2)
    {
        return [NSString stringWithFormat:@"最近访问城市"];
    }
    else if (section == 3)
    {
        return [NSString stringWithFormat:@"热门城市"];
    }
    else if(section > 3)
    {
        return self.captitalLetters[section - 4];
    }
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationItem];
    [self loadData];
    [self createTableView];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

-(void)initNavigationItem
{
    //定位默认为广州
    self.currentCity = @"广州";
    self.navigationItem.title = [NSString stringWithFormat: @"当前城市-%@", self.currentCity];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 4)];
    NSMutableArray *arrayCap = [[NSMutableArray alloc] initWithArray:self.captitalLetters];
    [arrayCap insertObjects:@[@"*", @"#", @"$", @"%"] atIndexes:indexSet];
    return arrayCap;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)didSelectCurrentCity
{
    NSString *message = [NSString stringWithFormat:@"是否将当前城市切换为 - %@", self.currentCity];
    UIAlertController *alterContrlller = [UIAlertController alertControllerWithTitle:@"切换当前城市" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *destructAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //切换导航栏的城市
        self.navigationItem.title = [NSString stringWithFormat: @"当前城市-%@", self.currentCity];
        self.IndexBlock(self.currentCity);
        
        //self.locationCityCell setValue:self.currentCity forKeyPath:(nonnull NSString *)
        //不会改 KVC方法
        //block方法 通过StoryBoard寻找回来的IndexVC 传值会崩毁
        //self.SecondBlock(self.currentCity);
    
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alterContrlller addAction:destructAction];
    [alterContrlller addAction:cancelAction];
    [self presentViewController:alterContrlller animated:YES completion:nil];
}

-(void)getCurrentCityAction:(NSString *)city
{
    self.currentCity = city;

    [self didSelectCurrentCity];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section > 3) {
        NSString *groupName = self.captitalLetters[indexPath.section - 4];
        NSArray *array = self.dictData[groupName];
        CityModel *model = array[indexPath.row];
        self.currentCity = model.city;
        
        [self didSelectCurrentCity];
    }
}

//-(void)tapSearchBar
//{
//    UIStoryboard *stroyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    SearchViewController *searchVC = [stroyBoard instantiateViewControllerWithIdentifier:@"searchVC"];
//    searchVC.dataArray = self.dataArray;
//    //    [searchBar resignFirstResponder];
//    
//    [self.navigationController pushViewController:searchVC animated:YES];
//}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    UIStoryboard *stroyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SearchViewController *searchVC = [stroyBoard instantiateViewControllerWithIdentifier:@"searchVC"];
    searchVC.dataArray = self.dataArray;
    
    [self.view endEditing:YES];
    [searchBar resignFirstResponder];
    
    [self.navigationController pushViewController:searchVC animated:YES];
}
/*
-(void)viewWillAppear:(BOOL)animated
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    SearchCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell.searchBar resignFirstResponder];
//    [cell.searchBar becomeFirstResponder];
    [self.view endEditing:YES];
}
*/

//-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
//{
//    return YES;
//}

//-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
//{
//    return YES;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
