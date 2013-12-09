//
//  DBCustomAD.m
//  CustomADTest
//
//  Created by Alex Tarrago on 11/24/13.
//  Copyright (c) 2013 Dribba Development. All rights reserved.
//

#import "DBCustomAD.h"

#define IS_IPHONE_5 (((double)[[UIScreen mainScreen] bounds].size.height) == ((double)568))

@implementation DBCustomAD

#pragma mark - 
#pragma mark UIButton Class Methods
- (id)          initWithFrame:(CGRect)frame             {
    if (IS_IPHONE_5) {
        large_banner = YES;
        frame = CGRectMake(0, 0, 320, 70);
    }else{
        large_banner = NO;
        frame = CGRectMake(0, 0, 320, 55);
    }
    self = [super initWithFrame:frame];
    if (self) {
        _refreshTime = 5;
        titles      = [[NSArray alloc] init];
        prices      = [[NSArray alloc] init];
        links       = [[NSArray alloc] init];
        images      = [[NSArray alloc] init];
        [self initBanner];
        [self setBackgroundColor:[UIColor lightGrayColor]];
    }
    return self;
}

#pragma mark - 
#pragma mark Custom Init Methods
- (void)        initBanner                              {
    [self start];
    [self setRandomBanner];
}

#pragma mark - 
#pragma mark Custom Methods
- (void)        fillBannerWithData:(NSArray *)data      {
    NSMutableArray *titles_temp = [[NSMutableArray alloc] init];
    NSMutableArray *links_temp = [[NSMutableArray alloc] init];
    NSMutableArray *prices_temp = [[NSMutableArray alloc] init];
    NSMutableArray *images_temp = [[NSMutableArray alloc] init];
    
    for (NSDictionary * information in data) {
        [titles_temp addObject:[information objectForKey:@"title"]];
        [prices_temp addObject:[information objectForKey:@"price"]];
        [links_temp addObject:[information objectForKey:@"link"]];
        
        if (large_banner) {
            [images_temp addObject:[information objectForKey:@"image_large"]];
        } else {
            [images_temp addObject:[information objectForKey:@"image_small"]];
        }
    }
    titles          = titles_temp;
    links           = links_temp;
    prices          = prices_temp;
    images          = images_temp;
    
    titles_temp     = nil;
    links_temp      = nil;
    prices_temp     = nil;
    images_temp     = nil;
}
- (void)        setRandomBanner                         {
    if (titles != nil) {
        int random = arc4random() % [titles count];
        current_banner = random;
        [self setBackgroundImage:[UIImage imageNamed:[images objectAtIndex:random]] forState:UIControlStateNormal];
    }
}

#pragma mark - 
#pragma mark UIButton and UITimer Handler Methods
- (void)        refreshBanner                           {
    [self setRandomBanner];
}
- (void)        userPushed:(id)sender                   {
    [[self delegate] customAd:self userDidClickWithAdID:[titles objectAtIndex:current_banner]];
    NSString* launchUrl = [links objectAtIndex:current_banner];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: launchUrl]];
}

#pragma mark - 
#pragma mark Activity Methods
- (void)        start                                   {
    [self addTarget:self action:@selector(userPushed:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString* list = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"json"];
    NSString * filePath     = nil;
    NSError * error         = nil;
    NSData * data           = [[NSData alloc] init];
    filePath                = list;
    data                    = [NSData dataWithContentsOfFile:filePath];
    NSDictionary * json     = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    [self fillBannerWithData:[json objectForKey:@"banners"]];
    [timer invalidate];
    timer = [NSTimer scheduledTimerWithTimeInterval:_refreshTime target:self selector:@selector(refreshBanner) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
- (void)        stop                                    {
    [timer invalidate];
    timer  = nil;
    titles  = nil;
    links   = nil;
    images  = nil;
    prices  = nil;
}


@end
