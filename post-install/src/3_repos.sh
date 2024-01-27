for u in $(cat ./options/repos.txt); do
    git clone $u ~/projects/$(basename $u);
done
