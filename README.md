# vsftpd-on-dodcker

Vsftpd（Very Secure FTP Daemon）是運行在 *類unix（Unix-like）* 上的 FTP 伺服器。

## 簡介

> 簡介尚未完成

## 快速運行

使用下面指令，就可以運行最新版的 vsftpd 應用：

```bash
$ docker run --name vsftpd \
    -p 20:20 \
    -p 21:21 \
    -d 48763/vsftpd
```

### 創建用戶

```bash
$ docker exec vsftpd \
    /bin/sh addftpuser yuki P@ssw0rd
```

## 掛載


### 資料保存

```bash
$ docker run --name vsftpd \
    -p 20:20 \
    -p 21:21 \
    -v /data:/data \
    -d 48763/vsftpd
```

### 配置保存


```bash
$ docker run --name vsftpd \
    -p 20:20 \
    -p 21:21 \
    -v $(pwd)/vsftpd:/etc/vsftpd \
    -d 48763/vsftpd
```


## 可用參數設定

| 參數 | 描述 | 預設值 | 相依參數 |
| -- | -- | -- | -- |
| PASV_ENABLE |  | NO | - |
| PASV_MIN_PORT |  | 60,000 | PASV_ENABLE |
| PASV_MAX_PORT |  | 61,000 | PASV_ENABLE |

## 被動模式

```bash
$ vi vsftpd.env
PASV_ENABLE=YES
```

```bash
$ docker run --name vsftpd \
    -p 20:20 \
    -p 21:21 \
    -p 60000-61000:60000-61000 \
    -e --env-file vsftpd.env \
    -d 48763/vsftpd
```

### 修改被動傳輸埠

```bash
$ vi vsftpd.env
PASV_MAX_PORT=48763
PASV_MIN_PORT=40000
```

```bash
$ docker run --name vsftpd \
    -p 20:20 \
    -p 21:21 \
    -p 40000-48763:40000-48763 \
    -e --env-file vsftpd.env \
    -d 48763/vsftpd
```

## 參考

[1] alpine, [FTP](https://wiki.alpinelinux.org/wiki/FTP), English  
[2] Archlinux, [Very Secure FTP Daemon](https://wiki.archlinux.org/index.php/Very_Secure_FTP_Daemon), English  
[3] tiwe-de, [libpam-pwdfile](https://github.com/tiwe-de/libpam-pwdfile), English  

