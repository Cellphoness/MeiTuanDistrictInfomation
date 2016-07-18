//
//  MeituanBaseClass.m
//
//  Created by 希哥  on 16/7/18
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "MeituanBaseClass.h"
#import "MeituanServerInfo.h"
#import "MeituanData.h"


NSString *const kMeituanBaseClassStid = @"stid";
NSString *const kMeituanBaseClassServerInfo = @"serverInfo";
NSString *const kMeituanBaseClassData = @"data";
NSString *const kMeituanBaseClassSugGid = @"sug_gid";


@interface MeituanBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MeituanBaseClass

@synthesize stid = _stid;
@synthesize serverInfo = _serverInfo;
@synthesize data = _data;
@synthesize sugGid = _sugGid;


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
            self.stid = [self objectOrNilForKey:kMeituanBaseClassStid fromDictionary:dict];
            self.serverInfo = [MeituanServerInfo modelObjectWithDictionary:[dict objectForKey:kMeituanBaseClassServerInfo]];
    NSObject *receivedMeituanData = [dict objectForKey:kMeituanBaseClassData];
    NSMutableArray *parsedMeituanData = [NSMutableArray array];
    if ([receivedMeituanData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedMeituanData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedMeituanData addObject:[MeituanData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedMeituanData isKindOfClass:[NSDictionary class]]) {
       [parsedMeituanData addObject:[MeituanData modelObjectWithDictionary:(NSDictionary *)receivedMeituanData]];
    }

    self.data = [NSArray arrayWithArray:parsedMeituanData];
            self.sugGid = [self objectOrNilForKey:kMeituanBaseClassSugGid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.stid forKey:kMeituanBaseClassStid];
    [mutableDict setValue:[self.serverInfo dictionaryRepresentation] forKey:kMeituanBaseClassServerInfo];
    NSMutableArray *tempArrayForData = [NSMutableArray array];
    for (NSObject *subArrayObject in self.data) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForData addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForData addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kMeituanBaseClassData];
    [mutableDict setValue:self.sugGid forKey:kMeituanBaseClassSugGid];

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

    self.stid = [aDecoder decodeObjectForKey:kMeituanBaseClassStid];
    self.serverInfo = [aDecoder decodeObjectForKey:kMeituanBaseClassServerInfo];
    self.data = [aDecoder decodeObjectForKey:kMeituanBaseClassData];
    self.sugGid = [aDecoder decodeObjectForKey:kMeituanBaseClassSugGid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_stid forKey:kMeituanBaseClassStid];
    [aCoder encodeObject:_serverInfo forKey:kMeituanBaseClassServerInfo];
    [aCoder encodeObject:_data forKey:kMeituanBaseClassData];
    [aCoder encodeObject:_sugGid forKey:kMeituanBaseClassSugGid];
}

- (id)copyWithZone:(NSZone *)zone
{
    MeituanBaseClass *copy = [[MeituanBaseClass alloc] init];
    
    if (copy) {

        copy.stid = [self.stid copyWithZone:zone];
        copy.serverInfo = [self.serverInfo copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
        copy.sugGid = [self.sugGid copyWithZone:zone];
    }
    
    return copy;
}


@end
