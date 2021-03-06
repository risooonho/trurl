#! /bin/bash
test -d /home/trurl/work/lock || mkdir -p /home/trurl/work/lock
(
    # wait 30 seconds for the lock (change if run at another interval)
    flock -x -w 30 210 && (
        cd /home/trurl/work/
        (test -f force/build || test -f force/update) && (./build_if_cvs_changed.sh)
        (test -f force/render) && (./update_logs.sh)
    )
) 210>/home/trurl/work/lock/force.lock
