#ifndef MYMAINWINDOW_H
#define MYMAINWINDOW_H

#include <QMainWindow>

class MyMainWindow : public QMainWindow
{
    Q_OBJECT
public:
    explicit MyMainWindow(QWidget *parent = nullptr);
    ~MyMainWindow();

    QString getName();
    virtual int getSize();

    bool isOpened = true;
    virtual void closeEvent(QCloseEvent *event);
};

#endif // MYMAINWINDOW_H
