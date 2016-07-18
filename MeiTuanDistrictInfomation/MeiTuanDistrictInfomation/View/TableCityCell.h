//
//  TableCityCell.h
//  Lesson_15_homework_meituan
//
//  Created by lanou on 16/4/22.
//  Copyright © 2016年 FJX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityCell.h"

//@class IndexViewController;

@protocol TableCityCellDelegate <NSObject>

-(void)getCurrentCityAction:(NSString *)city;

@end

@interface TableCityCell : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)NSArray *dataArray;
@property (nonatomic, weak)id <TableCityCellDelegate> delegate;
@property (nonatomic, strong)UICollectionView *CityTable;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithdataArray:(NSArray *)dataArray;

@end
