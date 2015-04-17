//
//  customcheckout.h
//  StoreModule
//
//  Created by AgilePc-100 on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@class AppDelegate;

@interface ZScustomcheckout : UITableViewCell
{
    UIImageView *productImg;
    UILabel *productLbl,*itempriceLbl,*itemtotalLbl,*qtyLable;
    UIButton *giftBtn,*giftwrapBtn,*removeBtn,*qtyBtnUp,*qtyBtnDown;
    UITextField *textFieldQty;
    AppDelegate *app;
}
@property (nonatomic,retain)UIImageView *productImg;
@property (nonatomic,retain)UITextField *textFieldQty;
@property (nonatomic,retain)UILabel *productLbl,*itempriceLbl,*itemtotalLbl,*qtyLable;
@property (nonatomic,retain)UIButton *giftBtn,*giftwrapBtn,*removeBtn,*qtyBtnUp,*qtyBtnDown;

@end
