/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import <Foundation/Foundation.h>

@class ABI22_0_0RCTRootView;

@protocol ABI22_0_0RCTRootViewDelegate <NSObject>

/**
 * Called after the root view's intrinsic content size is changed.
 *
 * The method is not called when both old size and new size have
 * a dimension that equals to zero.
 *
 * The delegate can use this callback to appropriately resize
 * the root view's frame to fit the new intrinsic content view size,
 * but usually it is not necessary because the root view will also call
 * `setNeedsLayout` for its superview which in its turn will trigger relayout.
 *
 * The new intrinsic content size is available via the `intrinsicContentSize`
 * propery of the root view. The view will not resize itself.
 */
- (void)rootViewDidChangeIntrinsicSize:(ABI22_0_0RCTRootView *)rootView;

@end
