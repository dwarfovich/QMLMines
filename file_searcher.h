#ifndef FILE_SEARCHER_H
#define FILE_SEARCHER_H

#include <QObject>

class FileSearcher : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList files READ files NOTIFY filesChanged)

public:
    explicit FileSearcher(QObject *parent = nullptr);

    const QStringList& files() const;

signals:
    void filesChanged();

    public slots:
    void search(const QString& folderPath);

private:
    QStringList m_files;


};

#endif // FILE_SEARCHER_H
