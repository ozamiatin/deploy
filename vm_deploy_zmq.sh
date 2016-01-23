git clone https://github.com/openstack-dev/devstack.git

cat > ./devstack/local.conf << EOF
[[local|localrc]]
DATABASE_PASSWORD=password
ADMIN_PASSWORD=password
SERVICE_PASSWORD=password
SERVICE_TOKEN=password
RABBIT_PASSWORD=password

enable_plugin zmq https://github.com/openstack/devstack-plugin-zmq.git

ZEROMQ_MATCHMAKER=redis
LIBS_FROM_GIT=oslo.messaging
ENABLE_DEBUG_LOG_LEVEL=True

    # core compute (glance / keystone / nova (+ nova-network))
ENABLED_SERVICES=g-api,g-reg,key,n-api,n-crt,n-obj,n-cpu,n-net,n-cond,n-sch,n-xvnc,n-cauth
    # cinder
ENABLED_SERVICES+=,cinder,c-sch,c-api,c-vol
# Neutron
ENABLED_SERVICES+=,q-svc,q-agt,q-dhcp,q-l3,q-meta,neutron
    # heat
ENABLED_SERVICES+=,h-eng,h-api,h-api-cfn,h-api-cw
    # dashboard
ENABLED_SERVICES+=,horizon
    # additional services
ENABLED_SERVICES+=,tempest,mysql
EOF
