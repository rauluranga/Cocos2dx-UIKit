//
//  InitialViewController.h
//  Cocos2dx-UIKit
//
//  Created by Alwyn Savio Concessao on 25/05/16.
//
//

#import <UIKit/UIKit.h>

@interface InitialViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *goButton;
@property (weak, nonatomic) IBOutlet UITextField *initialTextField;
- (IBAction)goButtonAction:(id)sender;

@end
