//
//  HeaderPageView.h
//  MeiTuanDistrictInfomation
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 FJX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeaderPageViewDelegate <NSObject>

-(void)didSelectTheShopWith:(NSString *)name;

@end

@interface HeaderPageView : UIView

@property (nonatomic, assign) id <HeaderPageViewDelegate> delegate;

+(instancetype)viewWithDataArray:(NSArray *)dataArray;
//-(instancetype)initWithCoder:(NSCoder *)aDecoder WithDataArray:(NSArray *)dataArray;
-(instancetype)initWithFrame:(CGRect)frame WithDataArray:(NSArray *)dataArray;

@end
