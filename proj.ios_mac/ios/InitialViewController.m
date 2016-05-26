//
//  InitialViewController.m
//  Cocos2dx-UIKit
//
//  Created by Alwyn Savio Concessao on 25/05/16.
//
//

#import "InitialViewController.h"
#import "GameViewController.h"
#import "MenuViewController.h"
#import "SWRevealViewController.h"

@interface InitialViewController ()

@end

@implementation InitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.initialTextField.delegate=self;
    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)goButtonAction:(id)sender {
    

    if(self.initialTextField.isFirstResponder){
        
        [self.initialTextField resignFirstResponder];
    
    }
    
        
        if([[self.initialTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""] caseInsensitiveCompare:@"Modal"] == NSOrderedSame){
            
            GameViewController *gameView = [[GameViewController alloc]init];
            gameView.presentationStyle=@"Modal";
            [self presentViewController:gameView animated:YES completion:nil];
            
        }else if([[self.initialTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""] caseInsensitiveCompare:@"Navigation"] == NSOrderedSame){
            
            MenuViewController *rightViewController = [[MenuViewController alloc] init];
            GameViewController *frontViewController = [[GameViewController alloc] init];
            frontViewController.presentationStyle=@"Navigation";
            SWRevealViewController *mainRevealController = [[SWRevealViewController alloc] init];
            [mainRevealController setRightViewController:rightViewController];
            [mainRevealController setFrontViewController:frontViewController];
            
            [[[UIApplication sharedApplication]delegate] window].rootViewController=mainRevealController;
            [[[[UIApplication sharedApplication]delegate] window] makeKeyAndVisible];
        }else{
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"You have entered an invalid choice.Please enter again correctly." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [textField becomeFirstResponder];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    [textField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return true;
}
@end
