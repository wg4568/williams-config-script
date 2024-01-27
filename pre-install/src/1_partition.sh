echo -e $PARTITIONS | sfdisk $1

if [ $? -ne 0 ]; then
    echo "Partitioning failed, drives are probably mounted."
    exit 1
fi
