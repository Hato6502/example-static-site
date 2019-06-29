PREFIX="https://b-hood.site"
SINCE="2019-06-01"
CURRENT_TIME="2019-06-25"

function loc() {
  # index.html は除去します。
  cat - | grep -E "\.html$" | sed "s/index\.html$//g"
}

function difftest () {
  # $1 コミットのハッシュ
  # $2 ファイルパス

  local diff=`git diff -U0 $1^..$1 -- $2 | tail -n +5 | grep -E "^(\+|-)"`
  # css のハッシュ変化は無視します。
  diff=`echo "${diff}" | grep -v "\/css\/app\.css"`
  return `[ -n "${diff}" ]`
}

function priority() {
  # $1 file path
  if [ $1 == `git rev-parse --show-toplevel`/index.html ]; then
    echo "1.0"
  else
    echo "0.5"
  fi
}

function lastmod() {
  # $1 file path
  if [ $1 == `git rev-parse --show-toplevel`/articles/index.html ]; then
    date --iso-8601 | w3cdatetime
  else
    cat -
  fi
}

function changefreq() {
  # $1 file path
  if [ $1 == `git rev-parse --show-toplevel`/articles/index.html ]; then
    echo "always"
  else
    cat -
  fi
}