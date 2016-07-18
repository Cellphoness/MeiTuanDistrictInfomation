//
//  IndexViewController.h
//  Lesson_15_homework_meituan
//
//  Created by lanou on 16/4/22.
//  Copyright © 2016年 FJX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^cityBlock)(NSString *city);
//typedef void (^localCityBlock)(NSString *city);

@interface IndexViewController : UIViewController

@property (nonatomic, strong)NSString *currentCity;
@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, copy)cityBlock IndexBlock;
//@property (nonatomic, copy)localCityBlock SecondBlock;

@end
