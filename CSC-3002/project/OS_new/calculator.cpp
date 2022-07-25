#include "calculator.h"
#include "ui_calculator.h"

int operationTimes = 0;
double sumInMemory = 0;
bool continueType = false;
QString lastOperation;

Calculator::Calculator(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::Calculator)
{
    ui->setupUi(this);

    connect(ui->pushButton_0,SIGNAL(released()),this,SLOT(digit_pressed()));
    connect(ui->pushButton_1,SIGNAL(released()),this,SLOT(digit_pressed()));
    connect(ui->pushButton_2,SIGNAL(released()),this,SLOT(digit_pressed()));
    connect(ui->pushButton_3,SIGNAL(released()),this,SLOT(digit_pressed()));
    connect(ui->pushButton_4,SIGNAL(released()),this,SLOT(digit_pressed()));
    connect(ui->pushButton_5,SIGNAL(released()),this,SLOT(digit_pressed()));
    connect(ui->pushButton_6,SIGNAL(released()),this,SLOT(digit_pressed()));
    connect(ui->pushButton_7,SIGNAL(released()),this,SLOT(digit_pressed()));
    connect(ui->pushButton_8,SIGNAL(released()),this,SLOT(digit_pressed()));
    connect(ui->pushButton_9,SIGNAL(released()),this,SLOT(digit_pressed()));

    connect(ui->pushButton_sign,SIGNAL(released()),this,SLOT(unary_operation_pressed()));
    connect(ui->pushButton_percent,SIGNAL(released()),this,SLOT(unary_operation_pressed()));

    connect(ui->pushButton_add,SIGNAL(released()),this,SLOT(binary_operation_pressed()));
    connect(ui->pushButton_minus,SIGNAL(released()),this,SLOT(binary_operation_pressed()));
    connect(ui->pushButton_multiply,SIGNAL(released()),this,SLOT(binary_operation_pressed()));
    connect(ui->pushButton_divide,SIGNAL(released()),this,SLOT(binary_operation_pressed()));

    ui->pushButton_add->setCheckable(true);
    ui->pushButton_minus->setCheckable(true);
    ui->pushButton_multiply->setCheckable(true);
    ui->pushButton_divide->setCheckable(true);
}

Calculator::~Calculator()
{
    delete ui;
}

void Calculator::digit_pressed()
{
    QPushButton *button = (QPushButton*) sender();

    double labelNumber;
    QString newLabel;

    if ((ui->pushButton_add->isChecked() || ui->pushButton_minus->isChecked() ||
         ui->pushButton_multiply->isChecked() || ui->pushButton_divide->isChecked()) &&
        (!continueType))
    {
        labelNumber = button->text().toDouble();
        newLabel = QString::number(labelNumber,'g',15);
        continueType = true;
    }
    else
    {   if (ui->lineEdit->text().contains('.') && button->text() == '0')
        {
            newLabel = ui->lineEdit->text() + button->text();
        }
        else
        {
            labelNumber = (ui->lineEdit->text() + button->text()).toDouble();
            newLabel = QString::number(labelNumber,'g',15);
        }
    }

    ui->lineEdit->setText(newLabel);
}

void Calculator::on_pushButton_dot_released()
{
    ui->lineEdit->setText(ui->lineEdit->text() + ".");
}

void Calculator::unary_operation_pressed()
{
    QPushButton *button =(QPushButton*) sender();
    double labelNumber;
    QString newLabel;

    if (button->text() == "+/-")
    {
        labelNumber = ui->lineEdit->text().toDouble();
        labelNumber = labelNumber * -1;
        newLabel = QString::number(labelNumber,'g',15);

        ui->lineEdit->setText(newLabel);
    }

    if (button->text() == "%")
    {
        labelNumber = ui->lineEdit->text().toDouble();
        labelNumber = labelNumber * 0.01;
        newLabel = QString::number(labelNumber,'g',15);

        ui->lineEdit->setText(newLabel);
    }
}

void Calculator::on_pushButton_clear_released()
{
    ui->pushButton_add->setChecked(false);
    ui->pushButton_minus->setChecked(false);
    ui->pushButton_multiply->setChecked(false);
    ui->pushButton_divide->setChecked(false);

    sumInMemory = 0;
    operationTimes = 0;
    continueType = false;
    lastOperation = "";

    ui->lineEdit->setText("0");
}

void Calculator::on_pushButton_equal_released()
{
    double labelNumber = 0;
    double anotherNum;
    QString newLabel;

    anotherNum = ui->lineEdit->text().toDouble();

    if (ui->pushButton_add->isChecked())
    {
        labelNumber = sumInMemory + anotherNum;
        newLabel = QString::number(labelNumber,'g',15);
        ui->lineEdit->setText(newLabel);
        ui->pushButton_add->setChecked(false);
    }
    else if (ui->pushButton_minus->isChecked())
    {
        labelNumber = sumInMemory - anotherNum;
        newLabel = QString::number(labelNumber,'g',15);
        ui->lineEdit->setText(newLabel);
        ui->pushButton_minus->setChecked(false);
    }
    else if (ui->pushButton_multiply->isChecked())
    {
        labelNumber = sumInMemory * anotherNum;
        newLabel = QString::number(labelNumber,'g',15);
        ui->lineEdit->setText(newLabel);
        ui->pushButton_multiply->setChecked(false);
    }
    else if (ui->pushButton_divide->isChecked())
    {
        labelNumber = sumInMemory / anotherNum;
        newLabel = QString::number(labelNumber,'g',15);
        ui->lineEdit->setText(newLabel);
        ui->pushButton_divide->setChecked(false);
    }

    sumInMemory = labelNumber;
    continueType = false;

    QPushButton *button =(QPushButton*) sender();
    lastOperation = button->text();
}

void Calculator::binary_operation_pressed()
{
    QPushButton *button =(QPushButton*) sender();

    operationTimes++;

    if (sumInMemory == 0 && operationTimes == 1){
        sumInMemory = ui->lineEdit->text().toDouble();
    }

    if (operationTimes !=1 )
    {
        double labelNumber = 0;
        double anotherNum;
        QString newLabel;

        anotherNum = ui->lineEdit->text().toDouble();

        if (lastOperation == "+")
        {
            labelNumber = sumInMemory + anotherNum;
            newLabel = QString::number(labelNumber,'g',15);
            ui->lineEdit->setText(newLabel);
            ui->pushButton_add->setChecked(false);
            sumInMemory = labelNumber;
        }
        else if (lastOperation == "-")
        {
            labelNumber = sumInMemory - anotherNum;
            newLabel = QString::number(labelNumber,'g',15);
            ui->lineEdit->setText(newLabel);
            ui->pushButton_minus->setChecked(false);
            sumInMemory = labelNumber;
        }
        else if (lastOperation == "*")
        {
            labelNumber = sumInMemory * anotherNum;
            newLabel = QString::number(labelNumber,'g',15);
            ui->lineEdit->setText(newLabel);
            ui->pushButton_multiply->setChecked(false);
            sumInMemory = labelNumber;
        }
        else if (lastOperation == "/")
        {
            labelNumber = sumInMemory / anotherNum;
            newLabel = QString::number(labelNumber,'g',15);
            ui->lineEdit->setText(newLabel);
            ui->pushButton_divide->setChecked(false);
            sumInMemory = labelNumber;
        }
        else if (lastOperation == "=")
        {
            sumInMemory = ui->lineEdit->text().toDouble();
        }

        continueType = false;
    }

    button->setChecked(true);
    lastOperation = button->text();
}
