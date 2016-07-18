//
//  MeituanData.m
//
//  Created by 希哥  on 16/7/18
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "MeituanData.h"


NSString *const kMeituanDataStid = @"_stid";
NSString *const kMeituanDataStg = @"_stg";
NSString *const kMeituanDataTotal = @"total";
NSString *const kMeituanDataKeyword = @"keyword";


@interface MeituanData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MeituanData

@synthesize stid = _stid;
@synthesize stg = _stg;
@synthesize total = _total;
@synthesize keyword = _keyword;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.stid = [self objectOrNilForKey:kMeituanDataStid fromDictionary:dict];
            self.stg = [self objectOrNilForKey:kMeituanDataStg fromDictionary:dict];
            self.total = [[self objectOrNilForKey:kMeituanDataTotal fromDictionary:dict] doubleValue];
            self.keyword = [self objectOrNilForKey:kMeituanDataKeyword fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.stid forKey:kMeituanDataStid];
    [mutableDict setValue:self.stg forKey:kMeituanDataStg];
    [mutableDict setValue:[NSNumber numberWithDouble:self.total] forKey:kMeituanDataTotal];
    [mutableDict setValue:self.keyword forKey:kMeituanDataKeyword];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.stid = [aDecoder decodeObjectForKey:kMeituanDataStid];
    self.stg = [aDecoder decodeObjectForKey:kMeituanDataStg];
    self.total = [aDecoder decodeDoubleForKey:kMeituanDataTotal];
    self.keyword = [aDecoder decodeObjectForKey:kMeituanDataKeyword];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_stid forKey:kMeituanDataStid];
    [aCoder encodeObject:_stg forKey:kMeituanDataStg];
    [aCoder encodeDouble:_total forKey:kMeituanDataTotal];
    [aCoder encodeObject:_keyword forKey:kMeituanDataKeyword];
}

- (id)copyWithZone:(NSZone *)zone
{
    MeituanData *copy = [[MeituanData alloc] init];
    
    if (copy) {

        copy.stid = [self.stid copyWithZone:zone];
        copy.stg = [self.stg copyWithZone:zone];
        copy.total = self.total;
        copy.keyword = [self.keyword copyWithZone:zone];
    }
    
    return copy;
}


@end
