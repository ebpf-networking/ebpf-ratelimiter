rate_map=${1}
port_map=${2}
recv_map=${3}
drop_map=${4}

echo "rate_map: " ${rate_map} " port_map: "${port_map}
echo "Setting rate"
#bpftool  map update id ${rate_map} key hex 00 00 00 00 value hex 00 00 00 00 00 00 00 01
#bpftool  map update id ${rate_map} key hex 00 00 00 00 value hex 11 11 11 11 11 11 11 11
bpftool  map update id ${rate_map} key hex 00 00 00 00 value hex 03 03 03 03 03 03 03 03
bpftool map dump  id ${rate_map}
echo "Setting port"
bpftool  map update id ${port_map} key hex 00 06  value hex 06
bpftool map dump  id ${port_map}
echo "Setting recv count"
bpftool  map update id ${recv_map} key hex 00 00 00 00 00 00 00 00 value hex 00 00 00 00 00 00 00 00
bpftool map dump  id ${recv_map}
echo "Setting drop count"
bpftool  map update id ${drop_map} key hex 00 00 00 00 00 00 00 00 value hex 00 00 00 00 00 00 00 00
bpftool map dump  id ${drop_map}
