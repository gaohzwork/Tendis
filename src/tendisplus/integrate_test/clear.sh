rm ./master1/  ./master2/ ./back_test/ -rf
rm ./m1_*/ ./m2_*/ ./s1_*/ ./s2_*/ ./m_*/ ./s_* -rf
rm ./m*_*/ -rf
rm ./src_*/ ./dst_*/ -rf
rm -f tendisplus*.log
rm -f valgrindTendis*.log
rm benchmark_*.log
rm predixy_* -rf
rm stderr*
rm redis-sync-*.conf 
rm sync-*.log

user=$USER
tpids=`ps axu |grep tendisplus|grep integrate_test| grep $user|awk '{print $2}'`
for tpid in $tpids
do
  echo "killing tendisplus process : $tpid"
  kill -9 $tpid
done

ppids=`ps axu |grep predixy   |grep integrate_test| grep $user|awk '{print $2}'`
for ppid in $ppids
do
  echo "killing predixy process : $ppid"
  kill -9 $ppid
done

rpids=`ps axu |grep redis-server | grep integrate_test | grep $user | awk '{print $2}'`
for rpid in $rpids
do
  echo "killing redis-server process : $rpid"
  kill -9 $rpid
done

spids=`ps axu |grep redis-sync | grep integrate_test | grep $user | awk '{print $2}'`
for spid in $spids
do
  echo "killing redis-sync process : $spid"
  kill -9 $spid
done

while true
do
    a=`ps axu |grep tendisplus|grep integrate_test|grep $user|grep -v "grep" |wc -l`
    if [ "$a" == "0" ]
    then
        break
    else
        sleep 1
    fi
done
