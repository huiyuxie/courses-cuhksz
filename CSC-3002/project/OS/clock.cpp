#include "clock.h"
#include "ui_clock.h"
#include <QPainter>
#include <QRadialGradient>
#include <QPainterPath>
#include <QTimer>
#include <QTime>
#include <QIcon>


clock::clock(QWidget *parent)
    : QWidget(parent)
    , ui(new Ui::clock)
{

    font.setPointSize(16);
    font.setFamily("华文行楷");
    font.setBold(false);
    setFont(font);


    QTimer *timer = new QTimer(this);
    timer->start(1000);
    connect(timer,SIGNAL(timeout()),this,SLOT(update()));
}


clock::~clock()
{
    delete ui;
}

void clock::setBackground(QString filename){
    this->filename = filename;
}


const QPoint clock::hourHand[4] = {
    QPoint(10, 4),
    QPoint(0, -15),
    QPoint(-10, 4),
    QPoint(0, -65)
        };


const QPoint clock::minuteHand[4] = {
    QPoint(6, 5),
    QPoint(0, -20),
    QPoint(-6, 5),
    QPoint(0, -120)
        };


const QPoint clock::secondHand[4] = {
    QPoint(4, 5),
    QPoint(0, 20),
    QPoint(-4, 5),
    QPoint(0, -180)
        };


void clock::drawHourHand(QPainter *painter)
{
    QTime time = QTime::currentTime();
    QRadialGradient gradient(225,210,210);
    gradient.setColorAt(0, qRgb(225,210,210));
    painter->setBrush(gradient);
    painter->setPen(qRgb(215,180,180));
    painter->save();
    painter->rotate(30.0*(time.hour()+time.minute()/60.0));
    painter->drawConvexPolygon(hourHand,4);
    painter->restore();
}


void clock::drawMinuteHand(QPainter *painter)
{
    QTime time = QTime::currentTime();
    QRadialGradient gradient(225,220,220);
    gradient.setColorAt(0, qRgb(225,220,220));
    painter->setBrush(gradient);
    painter->setPen(qRgb(215,180,180));
    painter->save();
    painter->rotate(6.0*(time.minute()+time.second()/60.0));
    painter->drawConvexPolygon(minuteHand,4);
    painter->restore();
}


void clock::drawsecondHand(QPainter *painter)
{
    QTime time = QTime::currentTime();
    QRadialGradient gradient(225,230,230);
    gradient.setColorAt(0, qRgb(225,230,230));
    painter->setBrush(gradient);
    painter->setPen(qRgb(215,180,180));
    painter->save();
    painter->rotate(6.0*time.second());
    painter->drawConvexPolygon(secondHand,4);
    painter->restore();
}




void clock::drawClockDial(QPainter *painter)
{
    QPen pen1;
    pen1.setWidth(4);
    pen1.setColor(qRgb(204,197,193));
    hourHandPen = pen1;

    QPen pen2;
    pen2.setWidth(2);
    pen2.setColor(qRgb(220,195,195));
    minuteHandPen = pen2;

     for (int i = 1; i <=60; ++i)
    {
        painter->save();
        painter->rotate(6*i);
        if (i % 5 == 0)
        {
            painter->setPen(hourHandPen);
            painter->drawLine(0, -190, 0, -170);


            painter->setPen(qRgb(220,195,195));
            painter->drawText(-20, -165, 40, 40,
              Qt::AlignHCenter | Qt::AlignTop,QString::number(i/5));
        }
        else
        {
            painter->setPen(minuteHandPen);
            painter->drawLine(0, -190, 0, -175);
        }
        painter->restore();
    }
}


void clock::gradientArc(QPainter *painter, int radius, int startAngle, int angleLength, int arcHeight) {
    QRadialGradient gradient(0, 0, radius);
    gradient.setColorAt(0, qRgb(255,225,255));
    painter->setBrush(gradient);


    QRectF rect(-radius, -radius, radius<<1, radius<<1);
    QPainterPath path;
    path.arcTo(rect, startAngle, angleLength);


    QPainterPath subPath;
    subPath.addEllipse(rect.adjusted(arcHeight, arcHeight, -arcHeight, -arcHeight));
    path -= subPath;


    painter->setPen(Qt::NoPen);
    painter->drawPath(path);
}




void clock::paintEvent(QPaintEvent *event)
{
    QPainter painter(this);

    QPixmap map(this->filename);

    QRect q(0,0,1600,900);

    QRect q2(0,0,width(),height());

    painter.drawPixmap(q2,map,q);

   painter.setRenderHint(QPainter::Antialiasing,true);

    int radius = 10;
    int arcHeight = 5;

    painter.save();
    painter.translate(1280,225);

    gradientArc(&painter, radius, 0, 360, arcHeight);

    drawClockDial(&painter);
    drawHourHand(&painter);
    drawMinuteHand(&painter);
    drawsecondHand(&painter);

    painter.restore();
}
