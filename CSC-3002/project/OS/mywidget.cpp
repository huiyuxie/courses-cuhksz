#include "mywidget.h"

MyWidget::MyWidget(QWidget *parent) : QWidget(parent){

}

MyWidget::~MyWidget(){

}

QString MyWidget::getName(){
    return this->windowTitle();
}

int MyWidget::getSize(){
    return 10;
}

void MyWidget::closeEvent(QCloseEvent *event){
    isOpened = false;
}
