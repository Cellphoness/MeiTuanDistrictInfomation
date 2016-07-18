//
//  CircleSearchTableViewController.m
//  MeiTuanDistrictInfomation
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 FJX. All rights reserved.
//

#import "CircleSearchTableViewController.h"
#import "SearchTextField.h"
#import "AFNetworking.h"
#import "HeaderPageView.h"

#define MEITUAN_URL @""

@interface CircleSearchTableViewController () <UITextFieldDelegate, HeaderPageViewDelegate>
@property (nonatomic, strong) SearchTextField *myField;
@end

@implementation CircleSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
//    sessionManager.responseSerializer = [AFImageResponseSerializer serializer];
//    [sessionManager GET:MEITUAN_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *dic2 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"dic___%@", dic2);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"ERROR___%@", error);
//    }];

    self.tableView.backgroundColor = [UIColor whiteColor];
    [self setNavItems];
    [self setHeaderView];
}

-(void)setHeaderView
{
    
//    HeaderPageView *headerPV = [[HeaderPageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 180) WithDataArray:@[@"上韩馆", @"广州塔", @"珠江夜游", @"利口福", @"点都德", @"华莱士", @"大卡司", @"贡茶", @"必胜客", @"上韩馆", @"广州塔", @"珠江夜游", @"利口福", @"点都德", @"华莱士"]];
    HeaderPageView *headerPV = [HeaderPageView viewWithDataArray:@[@"上韩馆", @"广州塔", @"珠江夜游", @"利口福", @"点都德", @"华莱士", @"大卡司", @"贡茶", @"必胜客", @"上韩馆", @"广州塔", @"珠江夜游", @"利口福", @"点都德", @"华莱士"]];
    headerPV.delegate = self;
    headerPV.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 180);
    self.tableView.tableHeaderView = headerPV;
}

-(void)setNavItems
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrayleft"] style:UIBarButtonItemStylePlain target:self action:@selector(popHandle)];
    self.myField = [[SearchTextField alloc] initWithFrame:CGRectMake(0, 0, 3 * self.view.bounds.size.width / 4, 27)];
    self.navigationItem.titleView = self.myField;
    self.myField.search.delegate = self;
}

-(void)didSelectTheShopWith:(NSString *)name
{
    self.myField.search.text = name;
}

-(void)popHandle
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
