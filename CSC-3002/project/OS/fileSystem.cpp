#include "filesystem.h"
#include <QMenuBar>
#include <QToolBar>
#include <QSize>
#include <QWindow>
#include <QFileInfo>
#include <QFile>
#include <QTextStream>
#include <QDebug>
#include <QMessageBox>
#include <QCloseEvent>
#include <QPushButton>
#include <QVBoxLayout>
#include <QTextCharFormat>
#include <QFontDialog>

FileSystem::FileSystem(QWidget *parent)
    : MyMainWindow(parent)
{
    setWindowTitle("Text Editor");
    setFixedSize(800,600);

    QMenuBar * bar = new QMenuBar;
    setMenuBar(bar);

    QMenu * file = bar->addMenu("File");
    QMenu * edit = bar->addMenu("Edit");
    QMenu * font = bar->addMenu("Font");
    QMenu * window = bar->addMenu("Window");
    QMenu * help = bar->addMenu("Help");

    QAction * Add = file->addAction("Add New File");
    QAction * Open = file->addAction("Open File");
    file->addSeparator();
    QAction * Save = file->addAction("Save");
    QAction * SaveAs = file->addAction("Save As");
    file->addSeparator();
    QAction * Exit = file->addAction("File Editor Exit");
    Add->setShortcut(tr("Ctrl+N"));
    Open->setShortcut(tr("Ctrl+O"));
    Save->setShortcut(tr("Ctrl+S"));
    SaveAs->setShortcut(tr("Ctrl+B"));
    Exit->setShortcut(tr("Ctrl+E"));

    QAction * Redo = edit->addAction("Redo");
    QAction * Undo = edit->addAction("Undo");
    edit->addSeparator();
    QAction * Cut = edit->addAction("Cut");
    QAction * Copy = edit->addAction("Copy");
    QAction * Paste = edit->addAction("Paste");
    Redo->setShortcut(tr("Ctrl+R"));
    Undo->setShortcut(tr("Ctrl+Z"));
    Cut->setShortcut(tr("Ctrl+T"));
    Copy->setShortcut(tr("Ctrl+C"));
    Paste->setShortcut(tr("Ctrl+V"));

    QAction * Font = font->addAction("Font");
    Font->setShortcut(tr("Ctrl+W"));

    QAction * Close = window->addAction("Close");
    QAction * CloseAll = window->addAction("Close All");
    window->addSeparator();
    QAction * Tile = window->addAction("Tile");
    QAction * Cascade = window->addAction("Cascade");
    window->addSeparator();
    QAction * Next = window->addAction("Next");
    QAction * Previous = window->addAction("Previous");
    Close->setShortcut(tr("Ctrl+L"));
    CloseAll->setShortcut(tr("Ctrl+M"));
    Tile->setShortcut(tr("Ctrl+I"));
    Cascade->setShortcut(tr("Ctrl+J"));
    Next->setShortcut(tr("Ctrl+U"));
    Previous->setShortcut(tr("Ctrl+R"));

    QAction * Search = help->addAction("Find");
    Search->setShortcut(tr("Ctrl+F"));

    QToolBar * toolbar = new QToolBar(this);
    addToolBar(Qt::RightToolBarArea,toolbar);
    toolbar->addAction(Add);
    toolbar->addAction(Open);
    toolbar->addAction(Save);
    toolbar->addAction(SaveAs);
    toolbar->addAction(Exit);
    toolbar->addAction(Redo);
    toolbar->addAction(Undo);
    toolbar->addAction(Cut);
    toolbar->addAction(Copy);
    toolbar->addAction(Paste);
    toolbar->addAction(Font);
    toolbar->addAction(Close);
    toolbar->addAction(CloseAll);
    toolbar->addAction(Tile);
    toolbar->addAction(Cascade);
    toolbar->addAction(Next);
    toolbar->addAction(Previous);
    toolbar->addAction(Search);

    MDI = new QMdiArea(this);
    MDI->setFixedSize(720,600);
    MDI->show();

    connect(Add, &QAction::triggered,this, &FileSystem::NewTriggerd);
    connect(Open, &QAction::triggered,this, &FileSystem::OpenTriggerd);
    connect(Save, &QAction::triggered,this, &FileSystem::SaveTriggerd);
    connect(SaveAs, &QAction::triggered,this, &FileSystem::SaveAsTriggerd);
    connect(Exit, &QAction::triggered,this, &FileSystem::ExitTriggerd);

    connect(Redo, &QAction::triggered,this, &FileSystem::RedoTriggerd);
    connect(Undo, &QAction::triggered,this, &FileSystem::UndoTriggerd);
    connect(Cut, &QAction::triggered,this, &FileSystem::CutTriggerd);
    connect(Copy, &QAction::triggered,this, &FileSystem::CopyTriggerd);
    connect(Paste, &QAction::triggered,this, &FileSystem::PasteTriggerd);

    connect(Font, &QAction::triggered,this, &FileSystem::FontTriggerd);

    connect(Close, &QAction::triggered,this, &FileSystem::CloseTriggerd);
    connect(CloseAll, &QAction::triggered,this, &FileSystem::CloseAllTriggerd);
    connect(Tile, &QAction::triggered,this, &FileSystem::TileTriggerd);
    connect(Cascade, &QAction::triggered,this, &FileSystem::CascadeTriggerd);
    connect(Next, &QAction::triggered,this, &FileSystem::NextTriggerd);
    connect(Previous, &QAction::triggered,this, &FileSystem::PreviousTriggerd);
    connect(Search, &QAction::triggered,this, &FileSystem::SearchTriggerd);


}

FileSystem::~FileSystem()
{
}

void FileSystem::NewTriggerd(){
    static int Number = 1;
    sub = new QTextEdit();
    MDI->addSubWindow(sub, Qt::CustomizeWindowHint);
    Filename = tr("Untitled%1.txt").arg(Number);
    sub->setWindowTitle(Filename + "[*]");
    sub->show();
    connect(sub, &QTextEdit::textChanged, this, &FileSystem::isEdited);
    ++Number;
    QMdiSubWindow *subWindow = MDI->activeSubWindow();
    map.insert(subWindow,sub);
    //connect(sub,&QTextEdit::destroyed,this,&MainWindow::CTriggerd);
}


void FileSystem::isEdited(){
    QMdiSubWindow *subWindow = MDI->activeSubWindow();
    subWindow->setWindowModified(true);
    this->setWindowModified(true);
}

void FileSystem::OpenTriggerd(){
    Flag = true;
    QFileDialog * Dialog = new QFileDialog;
    Path = Dialog->getOpenFileName(this,"Filename:",".","TEXT(*.cpp *.h *.txt)");
    QFileInfo info(Path);
    QString Title = info.fileName();
    QList <QMdiSubWindow*> List = MDI->subWindowList();
    for (int i = 0; i < List.size(); i++) {
        QMdiSubWindow *subWindow = List[i];
        if (subWindow->windowTitle() == Title){
            QMessageBox::warning(this,"Warning","This file has already been opened!");
            Flag = false;
            break;
        }
    }
    if ((Path.length()!=0) & (Flag==true)){
        QFile file(Path);
        sub = new QTextEdit();
        MDI->addSubWindow(sub);
        sub->setWindowTitle(info.fileName() + "[*]");
        if(file.open(QIODevice::ReadOnly | QIODevice::Text)){
            QTextStream in(&file);
            while (!in.atEnd()){
                sub->append(in.readLine());
            }
        }
        sub->show();
        Filename = sub->windowTitle();
        connect(sub, &QTextEdit::textChanged, this, &FileSystem::isEdited);
        QMdiSubWindow *subWindow = MDI->activeSubWindow();
        map.insert(subWindow,sub);
    }
}

void FileSystem::SaveTriggerd(){
    QMdiSubWindow *subWindow = MDI->activeSubWindow();
    if (subWindow == NULL){
        return;
    }
    sub = map[subWindow];
    Filename = subWindow->windowTitle();
    if (Filename.startsWith("Untitled")) {
        return SaveAsTriggerd();
    } else {
        QFile file(Path);
        if(file.open(QIODevice::WriteOnly | QIODevice::Text)){
            QTextStream out(&file);
            out << sub->toPlainText();
            subWindow->setWindowModified(false);
            QList <QMdiSubWindow*> List = MDI->subWindowList();
            for (int i = 0; i < List.size(); i++) {
                QMdiSubWindow *subWindow = List[i];
                if (subWindow->isWindowModified()==true){
                    this->setWindowModified(true);
                    break;
                } else {
                    this->setWindowModified(false);
                }
            }
        }
    }
}

void FileSystem::SaveAsTriggerd(){
    QMdiSubWindow *subWindow = MDI->activeSubWindow();
    if (subWindow == NULL){
        return;
    }
    sub = map[subWindow];
    Path = QFileDialog::getSaveFileName(this,"save",".","TEXT(*.cpp *.h *.txt)");
    if (Path.isEmpty()){
        return;
    } else {
        QFile file(Path);
        if(file.open(QIODevice::WriteOnly | QIODevice::Text)){
            QTextStream out(&file);
            out << sub->toPlainText();
        }
        QFileInfo info(Path);
        sub->setWindowTitle(info.fileName() + "[*]");
        Filename = sub->windowTitle();
        QMdiSubWindow *subWindow = MDI->activeSubWindow();
        subWindow->setWindowModified(false);
        QList <QMdiSubWindow*> List = MDI->subWindowList();
        for (int i = 0; i < List.size(); i++) {
            QMdiSubWindow *subWindow = List[i];
            if (subWindow->isWindowModified()==true){
                this->setWindowModified(true);
                break;
            } else {
                this->setWindowModified(false);
            }
        }
        QMessageBox::information(this,"success","The file is saved successufully!");
    }
}

void FileSystem::ExitTriggerd(){
    this->close();
}

void FileSystem::FontTriggerd(){
    QMdiSubWindow *subWindow = MDI->activeSubWindow();
    if (subWindow!=NULL){
        sub = map[subWindow];
        QTextCursor cursor = sub->textCursor();
        cursor.select(QTextCursor::WordUnderCursor);
        bool OK;
        QFont font = QFontDialog::getFont(&OK,QFont("Times New Roman",12));
        QTextCharFormat format;
        format.setFont(font);
        sub->mergeCurrentCharFormat(format);
    }
}

void FileSystem::CloseTriggerd(){
    QMdiSubWindow *subWindow = MDI->activeSubWindow();
    if (subWindow == NULL){
        return;
    }
    Filename = subWindow->windowTitle();
    if (!subWindow->isWindowModified()){
        MDI->closeActiveSubWindow();
    } else {
        QMessageBox::StandardButton btn = QMessageBox::information(this,"warning",
                 Filename + " hasn't been saved, do you want to save the file?",
                 QMessageBox::Yes | QMessageBox::No | QMessageBox::Cancel);
        if (btn == QMessageBox::Yes){
            SaveTriggerd();
            if (!Path.isEmpty()){
               MDI->closeActiveSubWindow();
            }
        } else if (btn == QMessageBox::No){
            MDI->closeActiveSubWindow();
        } else {
            return;
        }
    }
}

void FileSystem::CloseAllTriggerd(){
    QList <QMdiSubWindow*> List = MDI->subWindowList();
    for (int i = 0; i < List.size(); i++) {
        CloseTriggerd();
    }
}

void FileSystem::RedoTriggerd(){
    QMdiSubWindow *subWindow = MDI->activeSubWindow();
    if (subWindow!=NULL){
        sub = map[subWindow];
        sub->redo();
    }
}

void FileSystem::UndoTriggerd(){
    QMdiSubWindow *subWindow = MDI->activeSubWindow();
    if (subWindow!=NULL){
        sub = map[subWindow];
        sub->undo();
    }
}

void FileSystem::CutTriggerd(){
    QMdiSubWindow *subWindow = MDI->activeSubWindow();
    if (subWindow!=NULL){
        sub = map[subWindow];
        sub->cut();
    }
}

void FileSystem::CopyTriggerd(){
    QMdiSubWindow *subWindow = MDI->activeSubWindow();
    if (subWindow!=NULL){
        sub = map[subWindow];
        sub->copy();
    }
}

void FileSystem::PasteTriggerd(){
    QMdiSubWindow *subWindow = MDI->activeSubWindow();
    if (subWindow!=NULL){
        sub = map[subWindow];
        sub->paste();
    }
}

void FileSystem::TileTriggerd(){
    MDI->tileSubWindows();
}

void FileSystem::CascadeTriggerd(){
    MDI->cascadeSubWindows();
}

void FileSystem::NextTriggerd(){
    MDI->activateNextSubWindow();
}

void FileSystem::PreviousTriggerd(){
    MDI->activatePreviousSubWindow();
}

void FileSystem::SearchTriggerd(){
    search = new QDialog(this);
    search->resize(300,150);
    search->setWindowTitle("Search Word");
    line = new QLineEdit(search);
    QPushButton * btn = new QPushButton("Find", search);
    QVBoxLayout * layout = new QVBoxLayout(search);
    layout->addWidget(line);
    layout->addWidget(btn);
    connect(btn,&QPushButton::clicked,this,&FileSystem::Search);
    search->exec();
    if (search->Accepted){
        QList <QMdiSubWindow*> List = MDI->subWindowList();
        for (int i = 0; i < List.size(); i++) {
            QMdiSubWindow *subWindow = List[i];
            sub = map[subWindow];
            QTextCursor cursor = sub->textCursor();
            sub->moveCursor(QTextCursor::Start);
            cursor.select(QTextCursor::Document);
            QTextCharFormat * format = new QTextCharFormat;
            format->setForeground(Qt::black);
            cursor.mergeCharFormat(*format);
        }
    }
}

void FileSystem::Search(){
    Flag = false;
    QString string = line->text();
    if (string.trimmed().isEmpty()){
        QMessageBox::information(this,"empty","The search box is empty.");
        return;
    }
    QList <QMdiSubWindow*> List = MDI->subWindowList();
    for (int i = 0; i < List.size(); i++) {
        QMdiSubWindow *subWindow = List[i];
        sub = map[subWindow];
        QTextCursor cursor = sub->textCursor();
        sub->moveCursor(QTextCursor::Start);
        while (true){
            if (sub->find(string)){
                Flag = true;
                cursor.select(QTextCursor::WordUnderCursor);
                QTextCharFormat * format = new QTextCharFormat;
                format->setForeground(Qt::red);
                sub->mergeCurrentCharFormat(*format);
                continue;
            } else {
                break;
            }
        }
    }
    if (Flag == false){
        QMessageBox::information(this,"No text found","No text found.");
    }
}

void FileSystem::closeEvent(QCloseEvent *Event){
    QList <QMdiSubWindow*> List = MDI->subWindowList();
    if (List.size() == 0){
        Event->accept();
        isOpened = false;
    }
    for (int i = 0; i < List.size(); i++) {
        QMdiSubWindow *subWindow = List[i];
        if (subWindow->isWindowModified()==true){
            if (QMessageBox::Yes == QMessageBox::question(this,"warning",
                     "Changed file hasn't been saved, are you sure to exit?")){
                Event->accept();
                break;
            }
            Event->ignore();
            break;
        } else {
            Event->accept();
            isOpened = false;
        }
    }
}

int FileSystem::getSize(){
    int total = 0;
    total += 1024*1024*4;
    QList <QMdiSubWindow*> List = MDI->subWindowList();
    for(int i=0; i<List.size(); i++){
        QMdiSubWindow *subWindow = List[i];

    }
    return total;
}
//void QMdiSubWindow::closeEvent(QCloseEvent *Event){
//    qDebug()<<"Yes";
//}



