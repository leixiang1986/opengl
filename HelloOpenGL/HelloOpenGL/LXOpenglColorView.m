//
//  LXOpenglColorView.m
//  HelloOpenGL
//
//  Created by mac on 2018/12/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "LXOpenglColorView.h"
#import <OpenGLES/ES2/gl.h>

@implementation LXOpenglColorView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupOpenGL];
    }
    
    return self;
}


+ (Class)layerClass {
    return [CAEAGLLayer class];
}


- (void)setupOpenGL {
    // 1.创建EAGLContext
    /*
     最新OpenGL的版本是3.0, 但是从2.0到3.0的API的变化并不大.
     从1.0到2.0的API发生了巨大的转变
     1> 在openGL1.0的使用API非常的简单, openGL1.0称之为固定管线(api的很多的参数是固定, 也就是只能画出一个比较固定的图片)
     2> openGL2.0开始, 变成可编程管线. 让使用OpenGL更加的灵活, 同时也更加的复杂
     */
    EAGLContext *glContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:glContext];
    CAEAGLLayer *glLayer = (CAEAGLLayer *)self.layer;
    
    /*
     在OpenGL中, 无论你画多么简单的内容, 至少需要两个缓存区
     1> 渲染缓冲区
     * 记录当前画出内容的颜色
     2> 帧缓冲区
     * 渲染缓冲区是依赖于帧缓冲区进行显示
     GLuint
     作用: 是用于记录openGL中的对象,GLuint就相当于是某一个对象的ID, 之后我们想要操作某一个对象时, 只需要操作GLuint
     GLenum
     对应的是GPU中的一块内存地址
     */
    // 2.创建渲染缓冲区
    GLuint renderBuffers;
    glGenRenderbuffers(1, &renderBuffers);
    glBindRenderbuffer(GL_RENDERBUFFER, renderBuffers);
    [glContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:glLayer];
    
    // 3.创建帧缓冲区
    GLuint frameBuffers;
    glGenFramebuffers(1, &frameBuffers);
    glBindFramebuffer(GL_FRAMEBUFFER, frameBuffers);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, renderBuffers);
    
    // 4.显示内容
    glClearColor(1.0, 0.5, 0.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    [glContext presentRenderbuffer:GL_RENDERBUFFER];
}



- (void)setup {
    //创建上下文,并设置为当前的上下文
    EAGLContext *glCtx = [[EAGLContext alloc] initWithAPI:(kEAGLRenderingAPIOpenGLES2)];
    [EAGLContext setCurrentContext:glCtx];
    CAEAGLLayer *glLayer = (CAEAGLLayer *)self.layer;
    
    //创建渲染缓冲区
    GLuint renderBuffers;
    glGenRenderbuffers(1, &renderBuffers);
    glBindRenderbuffer(GL_RENDERBUFFER, renderBuffers);
    [glCtx renderbufferStorage:GL_RENDERBUFFER fromDrawable:glLayer];
    
    //创建帧缓冲区
    GLuint frameBuffers;
    glGenFramebuffers(1, &frameBuffers);
    glBindRenderbuffer(GL_FRAMEBUFFER, frameBuffers);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, renderBuffers);
    
    //显示内容
    glClearColor(1.0, 0.5, 0.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    [glCtx presentRenderbuffer:GL_RENDERBUFFER];
}

@end
