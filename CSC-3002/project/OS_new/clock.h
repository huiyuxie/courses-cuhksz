#ifndef CLOCK_H
#define CLOCK_H

#include <QDialog>

namespace Ui {
class Clock;
}

class Clock : public QDialog
{
    Q_OBJECT

public:
    explicit Clock(QWidget *parent = nullptr);
    ~Clock();

private:
    Ui::Clock *ui;

private slots:
    void showTime();
};

#endif // CLOCK_H
