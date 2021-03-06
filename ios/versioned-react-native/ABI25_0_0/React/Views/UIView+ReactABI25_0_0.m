/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "UIView+ReactABI25_0_0.h"

#import <objc/runtime.h>

#import "ABI25_0_0RCTAssert.h"
#import "ABI25_0_0RCTLog.h"
#import "ABI25_0_0RCTShadowView.h"

@implementation UIView (ReactABI25_0_0)

- (NSNumber *)ReactABI25_0_0Tag
{
  return objc_getAssociatedObject(self, _cmd);
}

- (void)setReactABI25_0_0Tag:(NSNumber *)ReactABI25_0_0Tag
{
  objc_setAssociatedObject(self, @selector(ReactABI25_0_0Tag), ReactABI25_0_0Tag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)nativeID
{
  return objc_getAssociatedObject(self, _cmd);
}

- (void)setNativeID:(NSNumber *)nativeID
{
  objc_setAssociatedObject(self, @selector(nativeID), nativeID, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#if ABI25_0_0RCT_DEV

- (ABI25_0_0RCTShadowView *)_DEBUG_ReactABI25_0_0ShadowView
{
  return objc_getAssociatedObject(self, _cmd);
}

- (void)_DEBUG_setReactABI25_0_0ShadowView:(ABI25_0_0RCTShadowView *)shadowView
{
  // Use assign to avoid keeping the shadowView alive it if no longer exists
  objc_setAssociatedObject(self, @selector(_DEBUG_ReactABI25_0_0ShadowView), shadowView, OBJC_ASSOCIATION_ASSIGN);
}

#endif

- (BOOL)isReactABI25_0_0RootView
{
  return ABI25_0_0RCTIsReactABI25_0_0RootView(self.ReactABI25_0_0Tag);
}

- (NSNumber *)ReactABI25_0_0TagAtPoint:(CGPoint)point
{
  UIView *view = [self hitTest:point withEvent:nil];
  while (view && !view.ReactABI25_0_0Tag) {
    view = view.superview;
  }
  return view.ReactABI25_0_0Tag;
}

- (NSArray<UIView *> *)ReactABI25_0_0Subviews
{
  return objc_getAssociatedObject(self, _cmd);
}

- (UIView *)ReactABI25_0_0Superview
{
  return self.superview;
}

- (void)insertReactABI25_0_0Subview:(UIView *)subview atIndex:(NSInteger)atIndex
{
  // We access the associated object directly here in case someone overrides
  // the `ReactABI25_0_0Subviews` getter method and returns an immutable array.
  NSMutableArray *subviews = objc_getAssociatedObject(self, @selector(ReactABI25_0_0Subviews));
  if (!subviews) {
    subviews = [NSMutableArray new];
    objc_setAssociatedObject(self, @selector(ReactABI25_0_0Subviews), subviews, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  }
  [subviews insertObject:subview atIndex:atIndex];
}

- (void)removeReactABI25_0_0Subview:(UIView *)subview
{
  // We access the associated object directly here in case someone overrides
  // the `ReactABI25_0_0Subviews` getter method and returns an immutable array.
  NSMutableArray *subviews = objc_getAssociatedObject(self, @selector(ReactABI25_0_0Subviews));
  [subviews removeObject:subview];
  [subview removeFromSuperview];
}

#pragma mark - Display

- (ABI25_0_0YGDisplay)ReactABI25_0_0Display
{
  return self.isHidden ? ABI25_0_0YGDisplayNone : ABI25_0_0YGDisplayFlex;
}

- (void)setReactABI25_0_0Display:(ABI25_0_0YGDisplay)display
{
  self.hidden = display == ABI25_0_0YGDisplayNone;
}

#pragma mark - Layout Direction

- (UIUserInterfaceLayoutDirection)ReactABI25_0_0LayoutDirection
{
  if ([self respondsToSelector:@selector(semanticContentAttribute)]) {
    return [UIView userInterfaceLayoutDirectionForSemanticContentAttribute:self.semanticContentAttribute];
  } else {
    return [objc_getAssociatedObject(self, @selector(ReactABI25_0_0LayoutDirection)) integerValue];
  }
}

- (void)setReactABI25_0_0LayoutDirection:(UIUserInterfaceLayoutDirection)layoutDirection
{
  if ([self respondsToSelector:@selector(setSemanticContentAttribute:)]) {
    self.semanticContentAttribute =
      layoutDirection == UIUserInterfaceLayoutDirectionLeftToRight ?
        UISemanticContentAttributeForceLeftToRight :
        UISemanticContentAttributeForceRightToLeft;
  } else {
    objc_setAssociatedObject(self, @selector(ReactABI25_0_0LayoutDirection), @(layoutDirection), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  }
}

#pragma mark - zIndex

- (NSInteger)ReactABI25_0_0ZIndex
{
  return self.layer.zPosition;
}

- (void)setReactABI25_0_0ZIndex:(NSInteger)ReactABI25_0_0ZIndex
{
  self.layer.zPosition = ReactABI25_0_0ZIndex;
}

- (NSArray<UIView *> *)ReactABI25_0_0ZIndexSortedSubviews
{
  // Check if sorting is required - in most cases it won't be.
  BOOL sortingRequired = NO;
  for (UIView *subview in self.subviews) {
    if (subview.ReactABI25_0_0ZIndex != 0) {
      sortingRequired = YES;
      break;
    }
  }
  return sortingRequired ? [self.ReactABI25_0_0Subviews sortedArrayUsingComparator:^NSComparisonResult(UIView *a, UIView *b) {
    if (a.ReactABI25_0_0ZIndex > b.ReactABI25_0_0ZIndex) {
      return NSOrderedDescending;
    } else {
      // Ensure sorting is stable by treating equal zIndex as ascending so
      // that original order is preserved.
      return NSOrderedAscending;
    }
  }] : self.subviews;
}

- (void)didUpdateReactABI25_0_0Subviews
{
  for (UIView *subview in self.ReactABI25_0_0Subviews) {
    [self addSubview:subview];
  }
}

- (void)ReactABI25_0_0SetFrame:(CGRect)frame
{
  // These frames are in terms of anchorPoint = topLeft, but internally the
  // views are anchorPoint = center for easier scale and rotation animations.
  // Convert the frame so it works with anchorPoint = center.
  CGPoint position = {CGRectGetMidX(frame), CGRectGetMidY(frame)};
  CGRect bounds = {CGPointZero, frame.size};

  // Avoid crashes due to nan coords
  if (isnan(position.x) || isnan(position.y) ||
      isnan(bounds.origin.x) || isnan(bounds.origin.y) ||
      isnan(bounds.size.width) || isnan(bounds.size.height)) {
    ABI25_0_0RCTLogError(@"Invalid layout for (%@)%@. position: %@. bounds: %@",
                self.ReactABI25_0_0Tag, self, NSStringFromCGPoint(position), NSStringFromCGRect(bounds));
    return;
  }

  self.center = position;
  self.bounds = bounds;
}

- (void)ReactABI25_0_0SetInheritedBackgroundColor:(__unused UIColor *)inheritedBackgroundColor
{
  // Does nothing by default
}

- (UIViewController *)ReactABI25_0_0ViewController
{
  id responder = [self nextResponder];
  while (responder) {
    if ([responder isKindOfClass:[UIViewController class]]) {
      return responder;
    }
    responder = [responder nextResponder];
  }
  return nil;
}

- (void)ReactABI25_0_0AddControllerToClosestParent:(UIViewController *)controller
{
  if (!controller.parentViewController) {
    UIView *parentView = (UIView *)self.ReactABI25_0_0Superview;
    while (parentView) {
      if (parentView.ReactABI25_0_0ViewController) {
        [parentView.ReactABI25_0_0ViewController addChildViewController:controller];
        [controller didMoveToParentViewController:parentView.ReactABI25_0_0ViewController];
        break;
      }
      parentView = (UIView *)parentView.ReactABI25_0_0Superview;
    }
    return;
  }
}

/**
 * Focus manipulation.
 */
- (BOOL)ReactABI25_0_0IsFocusNeeded
{
  return [(NSNumber *)objc_getAssociatedObject(self, @selector(ReactABI25_0_0IsFocusNeeded)) boolValue];
}

- (void)setReactABI25_0_0IsFocusNeeded:(BOOL)isFocusNeeded
{
  objc_setAssociatedObject(self, @selector(ReactABI25_0_0IsFocusNeeded), @(isFocusNeeded), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)ReactABI25_0_0Focus {
  if (![self becomeFirstResponder]) {
    self.ReactABI25_0_0IsFocusNeeded = YES;
  }
}

- (void)ReactABI25_0_0FocusIfNeeded {
  if (self.ReactABI25_0_0IsFocusNeeded) {
    if ([self becomeFirstResponder]) {
      self.ReactABI25_0_0IsFocusNeeded = NO;
    }
  }
}

- (void)ReactABI25_0_0Blur {
  [self resignFirstResponder];
}

#pragma mark - Layout

- (UIEdgeInsets)ReactABI25_0_0BorderInsets
{
  CGFloat borderWidth = self.layer.borderWidth;
  return UIEdgeInsetsMake(borderWidth, borderWidth, borderWidth, borderWidth);
}

- (UIEdgeInsets)ReactABI25_0_0PaddingInsets
{
  return UIEdgeInsetsZero;
}

- (UIEdgeInsets)ReactABI25_0_0CompoundInsets
{
  UIEdgeInsets borderInsets = self.ReactABI25_0_0BorderInsets;
  UIEdgeInsets paddingInsets = self.ReactABI25_0_0PaddingInsets;

  return UIEdgeInsetsMake(
    borderInsets.top + paddingInsets.top,
    borderInsets.left + paddingInsets.left,
    borderInsets.bottom + paddingInsets.bottom,
    borderInsets.right + paddingInsets.right
  );
}

- (CGRect)ReactABI25_0_0ContentFrame
{
  return UIEdgeInsetsInsetRect(self.bounds, self.ReactABI25_0_0CompoundInsets);
}

#pragma mark - Accessiblity

- (UIView *)ReactABI25_0_0AccessibilityElement
{
  return self;
}

@end
