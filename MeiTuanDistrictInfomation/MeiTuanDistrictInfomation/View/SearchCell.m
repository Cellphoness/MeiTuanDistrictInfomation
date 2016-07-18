//
//  SearchCell.m
//  Lesson_12_tabBarCpntroller作业
//
//  Created by lanou on 16/4/19.
//  Copyright © 2016年 FJX. All rights reserved.
//

#import "SearchCell.h"

@implementation SearchCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 20, self.frame.size.height)];
        self.searchBar.placeholder = @"城市/行政区/拼音";
        UITextField *searchField = [((UIView *)[self.searchBar.subviews objectAtIndex:0]).subviews lastObject];
        CGRect rect = searchField.frame;
        searchField.frame = CGRectMake(rect.origin.x, rect.origin.y - 15, rect.size.width, rect.size.height - 30);
        self.searchBar.showsCancelButton = YES;
//        [self.searchBar.subviews[0] removeFromSuperview];
        [self.searchBar setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:self.searchBar];
    }
    return self;
}

@end
