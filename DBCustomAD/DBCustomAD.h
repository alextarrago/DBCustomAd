//
//  DBCustomAD.h
//  CustomADTest
//
//  Created by Alex Tarrago on 11/24/13.
//  Copyright (c) 2013 Dribba Development. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 *  DBCustomAD Protocol
 */
@protocol DBCustomADDelegate <NSObject>
- (void) customAd:(id)controller userDidClickWithAdID:(NSString *)adID;
@end


@interface DBCustomAD : UIButton
{
    BOOL large_banner;
    int  current_banner;
    
    NSArray *titles;
    NSArray *prices;
    NSArray *images;
    NSArray *links;
    
    NSTimer *timer;
}

/*
 *  Class Properties
 */
@property (nonatomic, retain) id <DBCustomADDelegate> delegate;
@property (assign) int refreshTime;

/*
 *  Class Methods
 */
- (void) initBanner;
- (void) start;
- (void) stop;

@end
