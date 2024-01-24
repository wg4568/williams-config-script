for u in $(cat ./config/repos.txt); do
    git clone $u ~/projects/$(basename $u);
done
