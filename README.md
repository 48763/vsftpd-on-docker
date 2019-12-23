# vsftpd-on-dodcker

Vsftpd（Very Secure FTP Daemon）是運行在 *類unix（Unix-like）* 上的 FTP 伺服器。

## 簡介

### 輕量極鏡像

該鏡像使用 alpine 為基底建置，鏡像大小總和不到 10MB。

### 用戶認證

用戶認證採用 *libpam-pwdfile*，使用 `/etc/vsftpd/addftpuser` [創建用戶](#創建用戶)時，用戶列表會儲存在 `/etc/vsftpd/vsftpd-virtual-user`。

### 配置簡易：

啟用或變更被動模式，僅需更改 [`vsftpd.env`](#被動模式)，在啟用容器時，會自動帶入參數。如果要做更多的配置應用，直接掛載配置檔即可。

## 快速運行

使用下面指令，運行最新版的 vsftpd 應用，預設為主動模式：

```bash
$ docker run --name vsftpd \
    -p 20:20 \
    -p 21:21 \
    -d 48763/vsftpd
```

*如果使用時，遇到 `500 Illegal PORT command`，請使用[被動模式](#被動模式)。*

### 創建用戶

初次運行時，請使用下面指令新增**用戶**和**密碼**：

```bash
$ docker exec vsftpd \
    /bin/sh addftpuser yuki P@ssw0rd
```

## 掛載

使用目錄掛載，以配置或本地保存資料。

### 配置

運行時，掛載配置檔和用戶資料：

```bash
$ docker run --name vsftpd \
    -p 20:20 \
    -p 21:21 \
    -v $(pwd)/vsftpd:/etc/vsftpd \
    -d 48763/vsftpd
```



### 儲存資料

運行時，掛載儲放用戶的目錄資料：

```bash
$ docker run --name vsftpd \
    -p 20:20 \
    -p 21:21 \
    -v /data:/data \
    -d 48763/vsftpd
```

## 被動模式

### 可用參數

| 參數 | 描述 | 預設值 | 相依參數 |
| -- | -- | -- | -- |
| PASV_ENABLE |  | NO | - |
| PASV_MIN_PORT |  | 60,000 | PASV_ENABLE |
| PASV_MAX_PORT |  | 61,000 | PASV_ENABLE |

### 啟用被動模式

想要啟用被動模式，只要編輯 `vsftpd.env` 在運行即可：

```bash
$ vi vsftpd.env
PASV_ENABLE=YES

$ docker run --name vsftpd \
    -p 20:20 \
    -p 21:21 \
    -p 60000-61000:60000-61000 \
    -e --env-file vsftpd.env \
    -d 48763/vsftpd
```

### 修改被動傳輸埠

想要變更被動模式的傳輸埠，只要編輯 `vsftpd.env` 在運行即可：

```bash
$ vi vsftpd.env
PASV_MAX_PORT=48763
PASV_MIN_PORT=40000

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

