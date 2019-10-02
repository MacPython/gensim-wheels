set -euxo pipefail

RELEASE=$1

cd gensim
git fetch origin
git checkout "$RELEASE"
# git pull

cd ..
git commit gensim -m "update gensim submodule to point to tag $RELEASE"
