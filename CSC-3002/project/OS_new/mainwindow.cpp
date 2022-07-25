#include "mainwindow.h"
#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "calculator.h"
#include "clock.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_pushButton_clicked()
{
    calculator = new Calculator(this);
    calculator->show();
}

void MainWindow::on_pushButton_4_clicked()
{
    clock = new Clock(this);
    clock->show();
}
