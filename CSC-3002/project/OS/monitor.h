#ifndef MONITOR_H
#define MONITOR_H

#include <QWidget>
#include <vector>
#include "mymainwindow.h"
#include "mywidget.h"

QT_BEGIN_NAMESPACE
namespace Ui { class Monitor; }
QT_END_NAMESPACE

class Monitor : public MyWidget
{
    Q_OBJECT

public:
    Monitor(QWidget *parent = nullptr);
    ~Monitor();

    void loadWidget(std::vector<MyWidget*> processes);

    void loadMainWindow(std::vector<MyMainWindow*> processes);

    void refresh();

    void killProcess();

    void closeEvent(QCloseEvent *event);

    virtual int getSize();
private slots:
    void on_RefreshButton_clicked();

    void on_KillProcesButton_clicked();

    void on_tableWidget_cellClicked(int row, int column);

    void on_progressBar_valueChanged(int value);

private:
    Ui::Monitor *ui;
    std::vector<MyWidget*> listOfWidget;
    std::vector<MyMainWindow*> listOfMainWindow;
    int numOfWidget;
    int numOfMainWindow;
    int rowselected = -1;
    int memoryUsed = 0;
    const int memoryMaxiumum = 1024*1024*128;
};
#endif // MONITOR_H
