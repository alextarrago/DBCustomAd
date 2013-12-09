DBCustomAdvertisement
==========

DBCustomAD helps you to ad custom advertisement in your apps and promoting your products or services. It provides an easy way to include a custom UIButton with some cool features.

## Requirements

You should add the following frameworks to your project in order to work with DBCustomAD

    UIKit.framework

## Description

DBCustomAD adds a custom UIButton where you can place a custom image with related links, prices or titles.
The object could be initialized by:

    DBCustomAD *customAD = [[DBCustomAD alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [[self view] addSubview:customAD];

then just send the 'start' message to the object

    [customAD start];

----

## Options

### Configuration File

All the parametres can be modified in the config.json file included.
Just modify the following atributes according to your needs:

    {
        "title":"<Banner Name>",
        "price":"<Item Price>",
        "link":"<Item Link>",
        "image_large":"<Large Image Name>",
       " image_small":"<Small Image Name>"
    }

### Refreshing Times

    //Change this value to set the refreshing time (in seconds)
    [customAD setRefreshTime:5];

### Behaviour options

If you want to stop the refresh, just send the 'stop' message

    [customAD stop];


## Delegate Methods

DBCompassAD offers you some delegate methods to simplify your work

    - (void)    customAd:(id)controller userDidClickWithAdID:(NSString *)adID;

LICENSE
==========

Licensed under Apache License v2.0. A copy can be found inside this folder.