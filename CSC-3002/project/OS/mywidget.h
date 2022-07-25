#ifndef MYWIDGET_H
#define MYWIDGET_H

#include <QWidget>

class MyWidget : public QWidget{
    Q_OBJECT
public:
    explicit MyWidget(QWidget *parent = nullptr);
    ~MyWidget();

    QString getName();
    virtual int getSize();

    bool isOpened = true;
    virtual void closeEvent(QCloseEvent *event);
};

#endif // MYWIDGET_H
