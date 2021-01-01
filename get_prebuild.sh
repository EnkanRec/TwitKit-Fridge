#!/bin/bash -e
BASEPATH=$(cd `dirname $0`; pwd)
curl https://enkanrec.github.io/TwitKit-Fridge/Fridge.tgz | tar zxvf - -C $BASEPATH