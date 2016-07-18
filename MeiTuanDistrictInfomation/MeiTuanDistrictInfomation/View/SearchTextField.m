//
//  SearchTextField.m
//  Lesson_UI_07_UINavigationController
//
//  Created by lanou on 16/4/11.
//  Copyright © 2016年 FJX. All rights reserved.
//

#import "SearchTextField.h"

@implementation SearchTextField

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.searchImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.height - 5, self.frame.size.height - 5)];
        self.searchImage.layer.cornerRadius = (self.frame.size.height - 13) / 2;
        self.searchImage.clipsToBounds = YES;
        self.searchImage.backgroundColor = [UIColor clearColor];
        self.searchImage.image = [UIImage imageNamed:@"search"];
        self.search = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
        self.search.placeholder = @"输入商家, 品类, 商圈";
        self.search.font = [UIFont systemFontOfSize:12];
        self.search.leftViewMode = UITextFieldViewModeAlways;
        self.search.leftView = self.searchImage;
        self.search.layer.cornerRadius = 13;
       // self.search.layer.borderColor = [UIColor greenColor].CGColor;
        
        self.search.borderStyle = UITextBorderStyleRoundedRect;
        [self addSubview:self.search];
//        [self addSubview:self.searchImage];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
