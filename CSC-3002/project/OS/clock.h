#ifndef CLOCK_H
#define CLOCK_H

#include <QWidget>
#include <QPen>
#include <QFont>
#include <QPaintEvent>

namespace Ui {
class clock;
}


class clock : public QWidget
{
    Q_OBJECT

public:
    explicit clock(QWidget *parent = nullptr);
    ~clock();

    void paintEvent(QPaintEvent * event);
    void setBackground(QString filename);

private:
    Ui::clock *ui;

    static const QPoint hourHand[4];
    static const QPoint minuteHand[4];
    static const QPoint secondHand[4];
    QPen hourHandPen;
    QPen minuteHandPen;
    QFont font;
    QString filename = ":/image/wallpaper0.jpg";

    void gradientArc(QPainter *painter, int radius, int startAngle, int angleLength, int arcHeight);


protected:
    void drawHourHand(QPainter *painter);
    void drawMinuteHand(QPainter *painter);
    void drawsecondHand(QPainter *painter);
    void drawClockDial(QPainter *painter);
};
#endif // CLOCK_H





