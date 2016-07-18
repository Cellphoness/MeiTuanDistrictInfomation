//
//  SearchViewController.h
//  Lesson_15_homework_meituan
//
//  Created by lanou on 16/4/23.
//  Copyright © 2016年 FJX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController

@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSMutableArray *array;
@property (nonatomic, strong)NSMutableArray *searchList;
@property (nonatomic, strong)NSMutableArray *searchPinyin;


@property (nonatomic, strong)UISearchController *searchController;

@end
