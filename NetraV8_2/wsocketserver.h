#ifndef WSOCKETSERVER_H
#define WSOCKETSERVER_H

#include <QObject>
#include <QtCore>
#include <QtWebSockets>
#include <cstdio>
QT_FORWARD_DECLARE_CLASS(QWebSocketServer)
QT_FORWARD_DECLARE_CLASS(QWebSocket)
QT_FORWARD_DECLARE_CLASS(QString)
class WSocketServer : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString sendMessage READ sendMessage WRITE setSendMessage NOTIFY sendMessageChanged)
    Q_PROPERTY(QString hostIP READ hostIP WRITE setHostIP NOTIFY hostIPChanged)
    Q_PROPERTY(QString hostPort READ hostPort WRITE setHostPort NOTIFY hostPortChanged)
public:
    explicit WSocketServer(QObject *parent = nullptr);
    ~WSocketServer() override;
signals:
    void sendMessageChanged();
    void hostIPChanged();
    void hostPortChanged();
public:
    QString sendMessage();
    QString hostIP();
    QString hostPort();
    void setSendMessage(const QString& value);
    void setHostIP(const QString& value);
    void setHostPort(const QString& value);
private:
    QWebSocketServer *m_pWebSocketServer;
    QList<QWebSocket*> m_clients;
private slots:
    void onNewConnection();
    void processMessage(const QString & message);
    void socketDisconnected();
public:
//    QString port;
    QString m_hIp;
    QString m_msg;
    QString m_port;
};

#endif // WSOCKETSERVER_H
