#include "desktop.h"
#include "ui_desktop.h"
#include "mymainwindow.h"
#include "mywidget.h"
#include "monitor.h"
#include "filesystem.h"
#include <QTimer>
#include <QLabel>
#include <QDateTime>
#include <QFileDialog>
#include <QCalendarWidget>
#include <vector>

Desktop::Desktop(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{

    ui->setupUi(this);

    setFixedSize(1600,900);

    // current local time in statusbar
    QLabel *t_label = new QLabel();
    QTimer *timer = new QTimer();
    timer->start(1000);
    connect(timer,&QTimer::timeout,[=](){
        QDateTime currentTime = QDateTime::currentDateTime();
        QString strTime = currentTime.toString("dd.MM.yyyy, h:m:s ap");
        t_label->setText(strTime);
        ui->statusbar->addPermanentWidget(t_label);
    });

    clock = new class clock(this);
    setCentralWidget(clock);

    //   system event   //
    //shutdown
    connect(ui->actionshutdown, &QAction::triggered, [=](){
        this->close();
    });

    //setwallpaper (default size is 1600*900)
    connect(ui->actionsetwallpaper, &QAction::triggered, [=](){
        QString filename = QFileDialog::getOpenFileName(this, "select", "C:", "(*.jpg)");
        clock->setBackground(filename);
    });

    // applications //
    // calculator
    connect(ui->actioncalculator, &QAction::triggered, [=](){
        calculator = new Calculator(this);
        calculator->show();
    });

    // calendar
    connect(ui->actioncalendar, &QAction::triggered, [=](){
        QCalendarWidget *calendar = new QCalendarWidget();
        calendar->setWindowTitle("Calendar");
        calendar->setFixedSize(600,400);
        calendar->show();
    });

    connect(ui->actionMemory_Monitor, &QAction::triggered, [=](){
        if(monitor == nullptr){
            monitor = new Monitor();
            monitor->show();
            widgetList.push_back(monitor);
            monitor->loadWidget(widgetList);
            monitor->loadMainWindow(mainWindowList);
        }else{
            monitor->show();
        }
    });

    connect(ui->actionFile_System, &QAction::triggered, [=](){
        FileSystem *file = new FileSystem();
        file->show();
        mainWindowList.push_back(file);
        if(monitor != nullptr){
            monitor->loadWidget(widgetList);
            monitor->loadMainWindow(mainWindowList);
        }
    });
}

Desktop::~Desktop()
{
    delete ui;
}
