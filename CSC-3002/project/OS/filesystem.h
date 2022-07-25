#ifndef FILESYSTEM_H
#define FILESYSTEM_H

#include "mymainwindow.h"
#include <QMainWindow>
#include <QDialog>
#include <QFileDialog>
#include <QMdiArea>
#include <QString>
#include <QTextEdit>
#include <QLineEdit>
#include <QCloseEvent>
#include <QMdiSubWindow>
#include <QMap>

class FileSystem : public MyMainWindow
{
    Q_OBJECT

public:
    FileSystem(QWidget *parent = nullptr);
    ~FileSystem();

    void NewTriggerd();
    void isEdited();
    void OpenTriggerd();
    void SaveTriggerd();
    void SaveAsTriggerd();
    void ExitTriggerd();
    void CloseTriggerd();
    void CloseAllTriggerd();
    void FontTriggerd();
    void RedoTriggerd();
    void UndoTriggerd();
    void CutTriggerd();
    void CopyTriggerd();
    void PasteTriggerd();
    void TileTriggerd();
    void CascadeTriggerd();
    void NextTriggerd();
    void PreviousTriggerd();
    void SearchTriggerd();
    void Search();
    void closeEvent(QCloseEvent *Event);
    virtual int getSize();

private:
    QMdiArea * MDI;
    QString Filename;
    QString Path;
    QTextEdit * sub;
    QLineEdit * line;
    QDialog * search;
    bool Flag = true;
    int once;
    bool Edited =false;
    QMap <QMdiSubWindow*,QTextEdit*> map;
};
#endif // MAINWINDOW_H
