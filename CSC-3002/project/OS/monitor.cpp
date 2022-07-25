#include "monitor.h"
#include "ui_monitor.h"
#include <QMessageBox>
#include <QDebug>
#include <QTimer>

Monitor::Monitor(QWidget *parent)
    : MyWidget(parent)
    , ui(new Ui::Monitor)
{
    ui->setupUi(this);
    setWindowTitle("Memory Monitor");
    ui->tableWidget->setColumnCount(2);
    ui->progressBar->setMinimum(0);
    ui->progressBar->setMaximum(memoryMaxiumum);

    QTimer *timer = new QTimer();
    timer->start(1000);
    connect(timer, &QTimer::timeout, this, &Monitor::refresh);
    QStringList labels = QStringList() << "name" << "Size/KB";
    ui->tableWidget->setHorizontalHeaderLabels(labels);
}

Monitor::~Monitor(){
    delete ui;
}

void Monitor::loadWidget(std::vector<MyWidget *> processes){
    listOfWidget = processes;
    refresh();
}

void Monitor::loadMainWindow(std::vector<MyMainWindow *> processes){
    listOfMainWindow = processes;
    refresh();
}

void Monitor::refresh(){
    memoryUsed = 0;

    std::vector<int> closedWidget;
    std::vector<int> closedMainWindow;

    int idx = 0;
    for(MyWidget *process : listOfWidget){
        if(!process->isOpened){
            closedWidget.push_back(idx);
        }
        idx++;
    }

    idx = 0;
    for(MyMainWindow *process : listOfMainWindow){
        if(!process->isOpened){
            closedMainWindow.push_back(idx);
        }
        idx++;
    }

    while(!closedMainWindow.empty()){
        idx = closedMainWindow.back();
        closedMainWindow.pop_back();
        ui->tableWidget->removeRow(numOfWidget+idx);
        listOfMainWindow.erase(listOfMainWindow.begin() + idx);
    }

    while(!closedWidget.empty()){
        idx = closedWidget.back();
        closedWidget.pop_back();
        ui->tableWidget->removeRow(idx);
        listOfWidget.erase(listOfWidget.begin() + idx);
    }

    numOfWidget = listOfWidget.size();
    numOfMainWindow = listOfMainWindow.size();
    ui->tableWidget->setRowCount(numOfWidget+numOfMainWindow);
    for(int i=0; i<numOfWidget; i++){
        MyWidget *process = listOfWidget[i];
        QString name = process->getName();
        QString size = QString::number(process->getSize()/1024);
        ui->tableWidget->setItem(i, 0, new QTableWidgetItem(name));
        ui->tableWidget->setItem(i, 1, new QTableWidgetItem(size));
        memoryUsed += process->getSize();
    }

    for(int j=0; j<numOfMainWindow; j++){
        MyMainWindow *process = listOfMainWindow[j];
        QString name = process->getName();
        QString size = QString::number(process->getSize()/1024);
        ui->tableWidget->setItem(numOfWidget+j, 0, new QTableWidgetItem(name));
        ui->tableWidget->setItem(numOfWidget+j, 1, new QTableWidgetItem(size));
        memoryUsed += process->getSize();
    }
    ui->progressBar->setValue(memoryUsed);
}

void Monitor::killProcess(){
    if(rowselected >= 0 && rowselected < numOfWidget){
        listOfWidget[rowselected]->close();
        listOfWidget.erase(listOfWidget.begin() + rowselected);
        ui->tableWidget->removeRow(rowselected);
        refresh();
    } else if(rowselected >= numOfWidget && rowselected < numOfWidget+numOfMainWindow){
        listOfMainWindow[rowselected-numOfWidget]->close();
        listOfMainWindow.erase(listOfMainWindow.begin() + rowselected - numOfWidget);
        ui->tableWidget->removeRow(rowselected);
        refresh();
    } else{
        QMessageBox::critical(this, "Error", "No process selected");
    }
    rowselected = -1;
}

void Monitor::on_RefreshButton_clicked(){
    refresh();
}


void Monitor::on_KillProcesButton_clicked(){
    killProcess();
}

void Monitor::on_tableWidget_cellClicked(int row, int column){
    rowselected = row;
}

void Monitor::on_progressBar_valueChanged(int value){
    double ratio = double(value)/memoryMaxiumum;
    if(ratio > 0.95){
        QMessageBox::warning(this, "Memory Warning", "95% of the memory used, please close some process");
    }

    int idx = 0;
    for(MyWidget *process : listOfWidget){
        double ratio = double(process->getSize())/memoryMaxiumum;
        if(ratio >= 0.5 && ratio < 1){
            rowselected = idx;
            if(QMessageBox::Yes == QMessageBox::question(this, "Memory Warning",
                                  process->getName() + QString(" has used 50% of the memory, do you want"" to shut it down?"),
                                  QMessageBox::Yes | QMessageBox::No)){
                killProcess();
            }
        }
        idx ++;
    }

    for(MyMainWindow *process : listOfMainWindow){
        double ratio = double(process->getSize())/memoryMaxiumum;
        if(ratio >= 0.5 && ratio < 1){
            rowselected = idx;
            if(QMessageBox::Yes == QMessageBox::question(this, "Memory Warning",
                                  process->getName() + QString(" has used 50% of the memory, do you want"" to shut it down?"),
                                  QMessageBox::Yes | QMessageBox::No)){
                killProcess();
            }
        }
        idx ++;
    }
}

int Monitor::getSize(){
    int total = 0;
    // basic memory used
    total += 1024*1024;
    for(MyWidget *process : listOfWidget){
        //Memory of the pointer
        total += 4;

        //Memory of the size
        total += 8;

        //Memory of the name
        total += process->getName().size();
    }
    return total;
}

void Monitor::closeEvent(QCloseEvent *event){
    isOpened = true;
}
