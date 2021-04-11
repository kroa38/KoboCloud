#!/bin/bash

SERVICE=$1

TestFile=ulysses.epub
sha1=d07c5da10d4666766d1b796ba420cffca0ac440c

if [ "$SERVICE" = "dropbox" ]
then
    URL='https://www.dropbox.com/sh/qql9j10qldxfvkx/AAB6Fl2AEL78gD27fUNfEgJQa'
elif [ "$SERVICE" = "pcloud" ]
then
    URL='https://u.pcloud.link/publink/show?code=kZBWSsXZPYXgN8YJtmjGSKNCQERxG80M2WiX'
else
    URL='https://drive.google.com/drive/folders/1Wi37shmjG56L1D8OSdIZstkUfnpTsdAp'
fi

. src/usr/local/kobocloud/config_pc.sh

mkdir -p $Lib
rm -f $Lib/$TestFile
echo $URL > $UserConfig

src/usr/local/kobocloud/get.sh

if sha1sum $Lib/$TestFile | grep $sha1
then
    echo OK
    exit 0
else
    echo Failed
    exit 1
fi
