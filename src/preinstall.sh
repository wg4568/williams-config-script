if test -d $WORKING_DIR; then
    read -p "$WORKING_DIR exists, remove it? (yes/no) " -n 1 -r
    echo

    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        echo "Exiting."
        exit 0
    fi

    rm -rf $WORKING_DIR
    echo "Deleted."
fi

mkdir -p $WORKING_DIR
