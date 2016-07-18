//
//  HeaderPageView.m
//  MeiTuanDistrictInfomation
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 FJX. All rights reserved.
//

#import "HeaderPageView.h"
#import "CityCell.h"

@interface HeaderPageView () <UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation HeaderPageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib
{
   
}

+(instancetype)viewWithDataArray:(NSArray *)dataArray
{
    HeaderPageView *view = [[[NSBundle mainBundle] loadNibNamed:@"HeaderPageView" owner:nil options:nil] firstObject];
    view.dataArray = [NSArray arrayWithArray:dataArray];
    [view createAllUI];
    return view;
}
-(instancetype)initWithFrame:(CGRect)frame WithDataArray:(NSArray *)dataArray
{
    self = [[NSBundle mainBundle] loadNibNamed:@"HeaderPageView" owner:self options:nil][0];
    self.frame = frame;
    if (self) {
        self.dataArray = [NSArray arrayWithArray:dataArray];
    }
    return self;
}

//-(instancetype)initWithCoder:(NSCoder *)aDecoder WithDataArray:(NSArray *)dataArray
//{
//    self = [self initWithCoder:aDecoder];
//    if (self) {
//        _dataArray = dataArray;
//    }
//    return self;
//}

-(void)createAllUI
{
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.delegate = self;
    self.scrollView.tag = 111;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = self.scrollView.frame.size.height;
    self.scrollView.contentSize = CGSizeMake(width * 2, height);
    for (int i = 0; i <= self.dataArray.count / 9; i++) {
        [self createCollectionViewWithIndex:i];
    }
    self.pageControl.numberOfPages = self.dataArray.count / 9 + 1;
}

-(UICollectionView *)createCollectionViewWithIndex:(NSInteger )index
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = self.scrollView.frame.size.height;
    UICollectionViewFlowLayout *flowout = [[UICollectionViewFlowLayout alloc] init];
    flowout.minimumLineSpacing = 10;
    flowout.minimumInteritemSpacing = 10;
    flowout.itemSize = CGSizeMake(width / 3 - 15, height / 3 - 10);
    
    flowout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
//    flowout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGRect myRect = CGRectMake(width * index, 0, width, height);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:myRect collectionViewLayout:flowout];
    collectionView.tag = 123 + index;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [_scrollView addSubview:collectionView];
    UINib *nib = [UINib nibWithNibName:@"CityCell" bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:@"shop"];
    return collectionView;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSInteger count = 0;
    
    if (collectionView.tag == 123) {
        CityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shop" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        cell.CityLabel.text = self.dataArray[indexPath.row];
        cell.CityLabel.textColor = [UIColor darkGrayColor];
        cell.CityLabel.font = [UIFont systemFontOfSize:13];
        return cell;
    }
    else
    {
        CityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shop" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        cell.CityLabel.text = self.dataArray[indexPath.row + 9];
        cell.CityLabel.textColor = [UIColor darkGrayColor];
        cell.CityLabel.font = [UIFont systemFontOfSize:13];
        return cell;
    }
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.dataArray.count < 9) {
        return self.dataArray.count;
    }
    else
    {
        NSInteger number = collectionView.tag == 123 ? 9 : self.dataArray.count - 9;;
        return number;
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    self.pageControl.currentPage = scrollView.contentOffset.x / width;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger tagNum = 0;
    tagNum = collectionView.tag == 123 ? 0 : 9;
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectTheShopWith:)]) {
        [self.delegate didSelectTheShopWith:self.dataArray[indexPath.row + tagNum]];
    }
}

@end
