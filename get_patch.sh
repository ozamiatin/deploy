# $1 - change-id
# $2 - directory
# $3 - read-only checkout (https)

CHANGE_ID=$1
WORK_DIRECTORY=$2
READ_ONLY=$3

mkdir "$WORK_DIRECTORY"

if [ ! -d "$WORK_DIRECTORY" ]; then
	echo "$WORK_DIRECTORY was not created!"
	exit 1
fi

cd "$WORK_DIRECTORY"
virtualenv -p /usr/bin/python py27

if [ ! -d "py27" ]; then
	echo "py27 env was not created!"
	exit 1
fi

if [[ $READ_ONLY -eq "--read-only" ]] ; then
	echo "Cloning HTTPS"
	git clone https://review.openstack.org/openstack/oslo.messaging
else
	echo "Cloning SSH"
	git clone ssh://ozamiatin@review.openstack.org:29418/openstack/oslo.messaging
fi

cd ./oslo.messaging || exit 1
git review -d $CHANGE_ID

. ../py27/bin/activate
pip install .
pip install -r test-requirements.txt
deactivate
