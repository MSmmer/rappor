#!/bin/bash
#
# Usage:
#   ./run.sh <function name>

set -o nounset
set -o pipefail
set -o errexit

import-web() {
  local src=~/git/poly2/pylib/
  cp -v $src/{web.py,wsgiref_server.py,log.py,hello_web.py} .
}

import-poly() {
  local src=~/hg/polyweb/poly
  cp -v $src/{child.py,app_types.py} .
}

import-r() {
  local src=~/hg/polyweb
  cp -v \
    $src/pgi_lib/pgi.R \
    $src/app_root/examples/uber/pages.R \
    .
}

# Run the server in a way th
r-smoke-test() {
  ./hello_web.py --test
}

# For the API server.  Don't need shiny.
install-r-packages() {
  # Install as root so you can write to /usr/local/lib/R.
  sudo R -e \
    'install.packages(c("RJSONIO", "glmnet", "optparse"), repos="http://cran.rstudio.com/")'
}

count() {
  wc -l *.py *.R
}

"$@"
