#include "clock.h"
#include "ui_clock.h"
#include <QTimer>
#include <QDateTime>

Clock::Clock(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::Clock)
{
    ui->setupUi(this);
    QTimer *timer = new QTimer(this);
    connect(timer, SIGNAL(timeout()), this, SLOT(showTime()));
    timer->start();
}

Clock::~Clock()
{
    delete ui;
}

void Clock::showTime()
{
    QTime time = QTime::currentTime();
    QString time_text = time.toString("hh : mm : ss");
    ui->label->setText(time_text);
}
