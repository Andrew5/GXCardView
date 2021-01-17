//
//  GradientButton.h
//  wink
//
//  Created by 王斌 on 2019/8/8.
//  Copyright © 2019 王斌. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GradientButton : UIButton
@property (nullable, nonatomic,strong)UIColor *gradientStartColor;
@property (nullable, nonatomic,strong)UIColor *gradientEndColor;
@end

NS_ASSUME_NONNULL_END
