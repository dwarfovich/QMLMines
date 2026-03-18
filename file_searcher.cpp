#include "file_searcher.h"

#include <QDir>
#include <QDebug>

FileSearcher::FileSearcher(QObject *parent) : QObject { parent }
{
}

const QStringList &FileSearcher::files() const { return m_files; }

void FileSearcher::search(const QString &folderPath)
{
    QDir dir {folderPath};
    qDebug() << "Searching in " << dir.absolutePath();
    QStringList filters {"*Board.qml"};

    m_files = dir.entryList(filters, QDir::Files);
}
