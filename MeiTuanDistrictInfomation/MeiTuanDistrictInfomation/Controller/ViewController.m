//
//  ViewController.m
//  Lesson_15_homework_meituan
//
//  Created by lanou on 16/4/22.
//  Copyright © 2016年 FJX. All rights reserved.
//

#import "ViewController.h"
#import "SearchTextField.h"
#import "MyIndexView.h"
#import "IndexViewController.h"

@interface ViewController () <UITextFieldDelegate, MyIndexViewDelegate>

@property (nonatomic, strong)SearchTextField *myField;
@property (nonatomic, strong)MyIndexView *indexView;
@property (weak, nonatomic) IBOutlet UIButton *DistrictButton;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationItems];
    // Do any additional setup after loading the view, typically from a nib.
    
}

//下拉按钮的响应
- (IBAction)DistrictShowAction:(id)sender {
   
    if (self.DistrictButton.isSelected == NO)
    {
        [self.indexView setHidden:NO];
    }
    else
    {
        [self.indexView setHidden:YES];
    }
    self.DistrictButton.selected = !self.DistrictButton.isSelected;
}

//代理方法 响应下拉的地区信息的切换按钮
-(id)switchLocalCityAction:(id)sender
{
    IndexViewController *index = [[IndexViewController alloc] init];
    
    //使用Block传值
    __weak typeof(self) weakSelf = self;
    index.IndexBlock = ^(NSString *city)
    {
        NSString *str = [NSString stringWithFormat:@"当前城市: %@", city];
        weakSelf.indexView.cityLabel.text = str;
    };
    
    [self.navigationController pushViewController:index animated:YES];
    
    //点击后收起下拉的地区信息表
    [self.indexView setHidden:YES];
    self.DistrictButton.selected = !self.DistrictButton.isSelected;
    return self;
}

//代理方法 响应点击更新区域信息
-(id)getDistrictAction:(NSString *)distrctName
{
    [self.DistrictButton setTitle:distrctName forState:UIControlStateNormal];
    
    //点击后收起下拉的地区信息表
    [self.indexView setHidden:YES];
    self.DistrictButton.selected = !self.DistrictButton.isSelected;
    return self;
}

//创建并获取下拉的地区信息
- (MyIndexView *)getMyIndexView
{
    MyIndexView *districtView = [[MyIndexView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 270)];
    districtView.delegate = self;
    districtView.delegateForSelect = self;
    [districtView setHidden:YES];
    [self.view addSubview:districtView];
    return districtView;
}
//初始化导航栏
-(void)initNavigationItems
{
//    self.navigationController.navigationBar.barTintColor = [UIColor cyanColor];
    //72,192,163
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:72/255.f green:192/255.f blue:163/255.f alpha:1];
    self.myField = [[SearchTextField alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width / 2, 25)];
    self.navigationItem.titleView = self.myField;
    self.myField.search.delegate = self;
    
    //获取下拉地区列表的View并隐藏
    self.indexView = [self getMyIndexView];
    self.DistrictButton.selected = NO;
}

//搜索栏的响应

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
