while read -r -a line
do
    if [[ ${#line[@]} -gt 1 ]]; then
        dst=$(eval echo "${line[0]}")

        if [[ ${line[1]} = "CREATE" ]]; then
            sudo mkdir -p $dst
        else
            src=./files/${line[1]}
            sudo mkdir -p $(dirname $dst)
            sudo cp -rf $src $dst
        fi
    fi
done < ./options/files.txt

sudo chown -R $USER:$USER ~
