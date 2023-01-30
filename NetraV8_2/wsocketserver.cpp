#include "wsocketserver.h"
#include "QNetworkInterface"
#include <QDebug>
#include <QString>
using namespace std;

QT_USE_NAMESPACE
static QString getIdentifier(QWebSocket *peer)
{
    return QStringLiteral("%1:%2").arg(peer->peerAddress().toString(),
                                       QString::number(peer->peerPort()));
}
QString getIP(){
    QString hostIP;
    QNetworkInterface eth1Ip = QNetworkInterface::interfaceFromName("wlan0");
    QList<QNetworkAddressEntry> entries = eth1Ip.addressEntries();

    if (!entries.isEmpty()) {
        QNetworkAddressEntry entry = entries.first();
        hostIP = entry.ip().toString();
        qDebug() << "Host IP: "+hostIP ;
    }
    return hostIP;
}
WSocketServer::WSocketServer(QObject *parent):
    QObject (parent), m_port(1246),m_hIp("127.0.0.1"),
    m_pWebSocketServer(new QWebSocketServer(QStringLiteral("Chat Server"),
                                            QWebSocketServer::NonSecureMode,
                                            this))

{
    uint16_t setport = 1246;
    if (m_pWebSocketServer->listen(QHostAddress(getIP()),setport))
//    if (m_pWebSocketServer->listen(QHostAddress("192.168.43.116"),setport))
    {
        QTextStream(stdout)<< "server listening port"<<setport<<'\n';
//        QTextStream(stdout)<< "server listening port"<<m_port<<'\n';
        connect(m_pWebSocketServer, &QWebSocketServer::newConnection,
                this, &WSocketServer::onNewConnection);
    }
}

WSocketServer::~WSocketServer()
{
    m_pWebSocketServer->close();
}



void WSocketServer::onNewConnection()
{
    auto pSocket = m_pWebSocketServer->nextPendingConnection();
    QTextStream(stdout)<<getIdentifier(pSocket)<<"connected!\n";
    pSocket->setParent(this);

    connect(pSocket, &QWebSocket::textMessageReceived,
            this, &WSocketServer::processMessage);
    connect(pSocket, &QWebSocket::disconnected,
            this, &WSocketServer::socketDisconnected);
    m_clients << pSocket;
}

void WSocketServer::processMessage(const QString &message)
{
    QWebSocket *pSender = qobject_cast<QWebSocket *>(sender());
    for (QWebSocket *pClient : qAsConst(m_clients)){
        if (pClient!=pSender) {
            pClient->sendTextMessage(message);
            qDebug()<<message;
        }
    }
}

void WSocketServer::socketDisconnected()
{
    QWebSocket *pClient = qobject_cast<QWebSocket *>(sender());
    QTextStream(stdout)<<getIdentifier(pClient) << "disconnected!\n";
    if (pClient) {
        m_clients.removeAll(pClient);
        pClient->deleteLater();
    }
}

QString WSocketServer::sendMessage()
{

    return m_msg;
}

QString WSocketServer::hostIP()
{
    m_hIp = getIP();
    return m_hIp;
}

QString WSocketServer::hostPort()
{
    return m_port;
}

void WSocketServer::setSendMessage(const QString &value)
{
    if(m_msg!=value){
        m_msg = value;
        processMessage(m_msg);
        emit sendMessageChanged();
    }

}

void WSocketServer::setHostIP(const QString &value)
{
    if (m_hIp!=value) {
        m_hIp = value;
        emit hostIPChanged();
    }
}

void WSocketServer::setHostPort(const QString &value)
{
    if (m_port!=value) {
        m_port = value;

        emit hostPortChanged();
    }
}
