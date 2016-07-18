//
//  TableCityCell.m
//  Lesson_15_homework_meituan
//
//  Created by lanou on 16/4/22.
//  Copyright © 2016年 FJX. All rights reserved.
//

#import "TableCityCell.h"
//#import "IndexViewController.h"

@implementation TableCityCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithdataArray:(NSArray *)dataArray
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.dataArray = [[NSArray alloc] initWithArray:dataArray];
        self.CityTable = [self getCityIndexViewWithItemSize:CGSizeMake(90, 30)];
//        [self addSubview:self.CityTable];
        [self.contentView addSubview:self.CityTable];
    }
    return self;
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
    //static NSInteger count = 0;
    
    CityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"disct" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.CityLabel.text = self.dataArray[indexPath.row];
    cell.CityLabel.textColor = [UIColor blackColor];
    
    /*
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"IndexView" bundle:nil];
    IndexViewController *indexVC = [storyBoard instantiateViewControllerWithIdentifier:@"index"];
    if (count == 0) {
        NSLog(@"%@", indexVC);
        __weak typeof(cell) weakCell = cell;
        indexVC.SecondBlock = ^(NSString *city)
        {
            weakCell.CityLabel.text = city;
        };
    }
    count++;
     */
    return cell;
}

-(UICollectionView *)getCityIndexViewWithItemSize:(CGSize)ItemSize
{
    UICollectionViewFlowLayout *flowout = [[UICollectionViewFlowLayout alloc] init];
    flowout.minimumLineSpacing = 10;
    flowout.minimumInteritemSpacing = 10;
    flowout.itemSize = ItemSize;
    flowout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 20);
    flowout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    CGRect myRect = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, [UIScreen mainScreen].bounds.size.width, self.bounds.size.height + 50 * self.dataArray.count / 3);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:myRect collectionViewLayout:flowout];
    collectionView.backgroundColor = [UIColor lightGrayColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"CityCell" bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:@"disct"];
    return collectionView;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(getCurrentCityAction:)]) {
        [self.delegate getCurrentCityAction:self.dataArray[indexPath.row]];
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
