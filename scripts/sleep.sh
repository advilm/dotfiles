scripts/lock.sh;

while pidof i3lock; do 
  systemctl suspend
  sleep 30
done;
