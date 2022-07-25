#include "mymainwindow.h"

MyMainWindow::MyMainWindow(QWidget *parent) : QMainWindow(parent)
{

}

MyMainWindow::~MyMainWindow(){

}

QString MyMainWindow::getName(){
    return this->windowTitle();
}

int MyMainWindow::getSize(){
    return 10;
}

void MyMainWindow::closeEvent(QCloseEvent *event){
    isOpened = false;
}
