#ifndef FILE_SEARCHER_H
#define FILE_SEARCHER_H

#include <QObject>

class FileSearcher : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList files READ files NOTIFY filesChanged)

public:
    explicit FileSearcher(QObject *parent = nullptr);

    const QStringList& files() const { return m_files; }

signals:
    void filesChanged();

    private:
    void search()
    {
    }

private:
    QStringList m_files;


};

#endif // FILE_SEARCHER_H
