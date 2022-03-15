#!/bin/bash

echo "[INFO] Create a new version"
read -p "Give the targeted version: " VERSION

mkdir $VERSION
cat <<EOF >> $VERSION/Dockerfile
ARG VERSION="${VERSION}"
ARG BASE_IMAGE="pockost/hugo:onbuild"

FROM \${BASE_IMAGE}
EOF

exit

rm latest
ln -s $VERSION latest

git add $VERSION
git add latest
git commit -m "feat(release): Add $VERSION"
git tag $VERSION

git push gitlab master
git push origin master
git push gitlab $VERSION
git push origin $VERSION
