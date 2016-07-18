//
//  MyIndexView.h
//  Lesson_15_homework_meituan
//
//  Created by lanou on 16/4/22.
//  Copyright © 2016年 FJX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityCell.h"

@protocol MyIndexViewDelegate <NSObject>

-(id)switchLocalCityAction:(id )sender;

-(id)getDistrictAction:(NSString *)distrctName;

@end

@interface MyIndexView : UIView <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong)UICollectionView *cityIndex;
@property (nonatomic, strong)NSArray *dataArray;

@property (nonatomic, strong)UILabel *cityLabel;

@property (nonatomic, weak)id <MyIndexViewDelegate> delegate;
@property (nonatomic, weak)id <MyIndexViewDelegate> delegateForSelect;

@end
