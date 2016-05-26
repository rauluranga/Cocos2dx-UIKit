//
//  HelloWorldModalScene.h
//  Cocos2dx-UIKit
//
//  Created by Alwyn Savio Concessao on 25/05/16.
//
//

#ifndef HelloWorldModalScene_h
#define HelloWorldModalScene_h

#include "cocos2d.h"

class HelloWorldModalScene : public cocos2d::Layer
{
public:
    static cocos2d::Scene* createScene();
    
    virtual bool init();
    
    // a selector callback
    void menuCloseCallback(cocos2d::Ref* pSender);
    
    // implement the "static create()" method manually
    CREATE_FUNC(HelloWorldModalScene);
    
};

#endif