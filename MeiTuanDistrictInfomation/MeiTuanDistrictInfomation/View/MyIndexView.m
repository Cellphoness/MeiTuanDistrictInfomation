//
//  MyIndexView.m
//  Lesson_15_homework_meituan
//
//  Created by lanou on 16/4/22.
//  Copyright © 2016年 FJX. All rights reserved.
//

#import "MyIndexView.h"

@implementation MyIndexView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadData];
        self.cityIndex = [self getCityIndexViewWithItemSize:CGSizeMake(90, 30)];
        [self addSubview:self.cityIndex];
        self.backgroundColor = [UIColor grayColor];
        
        [self addSubview:[self getLocalItem]];
    }
    return self;
}

-(UIView *)getLocalItem
{
    CGRect myRect = CGRectMake(self.bounds.origin.x + 10, self.bounds.size.height - 50, self.bounds.size.width - 20, 40);
    UIView *localItem = [[UIView alloc] initWithFrame:myRect];
    localItem.backgroundColor = [UIColor whiteColor];
    self.cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(localItem.bounds.origin.x + 5, localItem.bounds.origin.y + 10, 150, 20)];
    self.cityLabel.text = @"当前城市: 广州";
    self.cityLabel.font = [UIFont systemFontOfSize:15];
    [localItem addSubview:self.cityLabel];
    
    UIButton *btnSwitchLocalCity = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSwitchLocalCity.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 100,  localItem.bounds.origin.y + 10, 70, 20);
    [btnSwitchLocalCity setTitle:@"更换" forState:UIControlStateNormal];
    [btnSwitchLocalCity setTitleColor:[UIColor colorWithRed:72/255.f green:192/255.f blue:163/255.f alpha:1] forState:UIControlStateNormal];
    [btnSwitchLocalCity setImage:[UIImage imageNamed:@"array"] forState:UIControlStateNormal];
    
    btnSwitchLocalCity.titleLabel.font = [UIFont systemFontOfSize:15];
    [btnSwitchLocalCity setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 7)];
    [btnSwitchLocalCity setImageEdgeInsets:UIEdgeInsetsMake(0, 60, 0, 0)];
    
    [btnSwitchLocalCity addTarget:self.delegate action:@selector(switchLocalCityAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [localItem addSubview:btnSwitchLocalCity];
    
    return localItem;
}

-(UICollectionView *)getCityIndexViewWithItemSize:(CGSize)ItemSize
{
        UICollectionViewFlowLayout *flowout = [[UICollectionViewFlowLayout alloc] init];
        flowout.minimumLineSpacing = 10;
        flowout.minimumInteritemSpacing = 10;
        flowout.itemSize = ItemSize;
        flowout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        flowout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    CGRect myRect = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height - 60);
    
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame: myRect collectionViewLayout:flowout];
    collectionView.backgroundColor = [UIColor lightGrayColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"CityCell" bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:@"disct"];
    return collectionView;
}

-(void)loadData
{
    self.dataArray = @[@"全城", @"番禺区", @"海珠区", @"越秀区", @"荔湾区", @"白云区", @"天河区", @"南沙区", @"增城区", @"花都区", @"黄埔区", @"从化市", @"近郊"];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"disct" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.CityLabel.text = self.dataArray[indexPath.row];
    cell.CityLabel.textColor = [UIColor blackColor];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegateForSelect && [self.delegateForSelect respondsToSelector:@selector(getDistrictAction:)]) {
        [self.delegateForSelect getDistrictAction:self.dataArray[indexPath.row]];
    }
}

@end
