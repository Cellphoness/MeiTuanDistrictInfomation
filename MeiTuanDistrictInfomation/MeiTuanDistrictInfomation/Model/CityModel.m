//
//  CityModel.m
//  Lesson_UI_11_news
//
//  Created by lanou on 16/4/22.
//  Copyright © 2016年 FJX. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@, %@", self.city, self.pinyinForCity];
}

@end
