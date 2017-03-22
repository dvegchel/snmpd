# snmpd
SNMPD daemon for OSE
Daemonset for SNMPD on OpenShift nodes (old-skool monitoring). 

Install: 
1. Create snmpd sa (oc create -f snmpd-sa.yml)
2. Add snmpd sa to scc/privileged (daemon needs to run on hostnetwork and mount /proc), oc edit scc/privileged
3. Create daemonset (oc create -f snmpd-ds.yml)
4. Allow snmpd port 161 udp on host.
