# hunrul

Az adatbázist innen exportáltam CIDR formátumban.
http://software77.net/geo-ip/

Egy HUN nevű láncot készít, amit aztán pl. INPUT, FORWARD-ban lehet használni.

<code>
iptables -I INPUT 1 -j HUN
</code>
