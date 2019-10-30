#!/bin/sh

. ./.env

# spin until process dies
spin0="-";spin1="\\";spin2="|";spin3="/";spinloop=0
spinps() {
  pid=$1
  while [ "$(ps -ef | awk '{print $2}' | grep -w $pid)" ]; do
    eval pspin="\${spin${spinloop}}"
    echo "$pspin \r\c"
    sleep 0.05
    spinloop=`expr $spinloop + 1`
    case $spinloop in
      4) spinloop=0 ;;
    esac
  done
}

cd $docker_dir

[ ! -d $old_backups ] && mkdir $old_backups

echo "Backing up influxdb"
docker exec -it influxdb influxd backup -portable /var/lib/influxdb/backup 2>&1 > /dev/null
[ -d $old_backups/influxdb ] && { echo "Removing old influxdb backups from $old_backups"; rm -rf $old_backups/influxdb; }
[ -d $backups/influxdb ] && { echo "Moving current influxdb backups to $old_backups"; mv -f $backups/influxdb $old_backups; }
docker cp influxdb:/var/lib/influxdb/backup/ $backups/influxdb/

do_backup() {
  echo ""
  echo "Moving previous backup to ${backup_name}.bkup"
  rm -f ${backup_name}.bkup
  [ -f $backup_name ] && mv -f $backup_name ${backup_name}.bkup
  echo ""
  echo "Creating backup tarball $backup_name"
  sudo tar cfz $backup_name $docker_compose_dir/.env $containers $backups/influxdb 2>&1 > /dev/null &
  spinps $! || { echo "Backup failed"; exit 1; } && echo "Backup complete"
}

[ -f $backup_name ] && do_backup
