vm_ip=$1

echo $vm_ip

scp ./vm_deploy_zmq.sh $vm_ip:/home/ozamiatin/vm_deploy_zmq.sh
ssh $vm_ip sh /home/ozamiatin/vm_deploy_zmq.sh

ssh $vm_ip sh /home/ozamiatin/devstack/stack.sh
