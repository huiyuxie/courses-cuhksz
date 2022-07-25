#ifndef DESKTOP_H
#define DESKTOP_H

#include <QMainWindow>
#include "clock.h"
#include "calculator.h"
#include "mymainwindow.h"
#include "mywidget.h"
#include "monitor.h"
#include <vector>

QT_BEGIN_NAMESPACE
namespace Ui { class MainWindow; }
QT_END_NAMESPACE

class Desktop : public QMainWindow
{
    Q_OBJECT

public:
    Desktop(QWidget *parent = nullptr);
    ~Desktop();

private:
    Ui::MainWindow *ui;
    class clock *clock;
    Calculator *calculator;
    Monitor *monitor = nullptr;

    std::vector<MyWidget*> widgetList;
    std::vector<MyMainWindow*> mainWindowList;
};
#endif // MAINWINDOW_H
