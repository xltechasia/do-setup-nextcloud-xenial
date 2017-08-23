  "user_backends" => array (
    0 => array (
      "class"     => "OC_User_IMAP",
      "arguments" => array (
        0 => '{imap.travelogix.sg:993/imap/ssl}'
        ),
    ),
  ),

#!/bin/bash
ncpath='/var/www/nextcloud'
ncdatapath='/var/www/nextcloud-data'
htuser='www-data'
htgroup='www-data'
rootuser='root'

if [ -z "$1" ]; then
    runargs="fix"
else
    runargs="$1"
fi

case "$runargs" in
    --update)
        printf "Setting Permissions to allow online upgrade\n"
        printf "Creating possible missing Directories\n"
        mkdir -p $ncdatapath
        mkdir -p $ncpath/assets
        mkdir -p $ncpath/updater

        printf "chmod Files and Directories\n"
        find ${ncpath}/ -type f -print0 | xargs -0 chmod 0777
        find ${ncdatapath}/ -type f -print0 | xargs -0 chmod 0777

        find ${ncpath}/ -type d -print0 | xargs -0 chmod 0777
        find ${ncdatapath}/ -type d -print0 | xargs -0 chmod 0777

        printf "chown Directories\n"
        chown -R ${htuser}:${htgroup} ${ncpath}/
        chown -R ${htuser}:${htgroup} ${ncdatapath}/
        chown -R ${htuser}:${htgroup} ${ncpath}/apps/
        chown -R ${htuser}:${htgroup} ${ncpath}/assets/
        chown -R ${htuser}:${htgroup} ${ncpath}/config/
        chown -R ${htuser}:${htgroup} ${ncpath}/themes/
        chown -R ${htuser}:${htgroup} ${ncpath}/updater/

        chmod +x ${ncpath}/occ

        printf "chmod/chown .htaccess\n"
        if [ -f ${ncpath}/.htaccess ]
         then
          chmod 0777 ${ncpath}/.htaccess
          chown ${htuser}:${htgroup} ${ncpath}/.htaccess
        fi

        if [ -f ${ncpath}/data/.htaccess ]
         then
          chmod 0777 ${ncpath}/data/.htaccess
          chown ${htuser}:${htgroup} ${ncpath}/data/.htaccess
        fi

        if [ -f ${ncdatapath}/.htaccess ]
         then
          chmod 0777 ${ncdatapath}/.htaccess
          chown ${htuser}:${htgroup} ${ncdatapath}/.htaccess
        fi

        printf "*** Permissions are very open - be sure to run this again after the update!!!!\n"

        ;;

    *)
        printf "Creating possible missing Directories\n"
        mkdir -p $ncdatapath
        mkdir -p $ncpath/assets
        mkdir -p $ncpath/updater

        printf "chmod Files and Directories\n"
        find ${ncpath}/ -type f -print0 | xargs -0 chmod 0640
        find ${ncdatapath}/ -type f -print0 | xargs -0 chmod 0640

        find ${ncpath}/ -type d -print0 | xargs -0 chmod 0750
        find ${ncdatapath}/ -type d -print0 | xargs -0 chmod 0750

        printf "chown Directories\n"
        chown -R ${rootuser}:${htgroup} ${ncpath}/
        chown -R ${htuser}:${htgroup} ${ncdatapath}/
        chown -R ${htuser}:${htgroup} ${ncpath}/apps/
        chown -R ${htuser}:${htgroup} ${ncpath}/assets/
        chown -R ${htuser}:${htgroup} ${ncpath}/config/
        chown -R ${htuser}:${htgroup} ${ncpath}/themes/
        chown -R ${htuser}:${htgroup} ${ncpath}/updater/

        chmod +x ${ncpath}/occ

        printf "chmod/chown .htaccess\n"
        if [ -f ${ncpath}/.htaccess ]
         then
          chmod 0644 ${ncpath}/.htaccess
          chown ${rootuser}:${htgroup} ${ncpath}/.htaccess
        fi

        if [ -f ${ncpath}/data/.htaccess ]
         then
          chmod 0644 ${ncpath}/data/.htaccess
          chown ${rootuser}:${htgroup} ${ncpath}/data/.htaccess
        fi

        if [ -f ${ncdatapath}/.htaccess ]
         then
          chmod 0644 ${ncdatapath}/.htaccess
          chown ${rootuser}:${htgroup} ${ncdatapath}/.htaccess
        fi
        ;;
esac

exit 0
