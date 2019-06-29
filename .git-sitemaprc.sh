PREFIX="https://b-hood.site"
SINCE="1 month ago"

function loc() {
  # index.html は除去します。
  cat - | sed "s/index\.html$//g"
}

function difftest () {
  # $1 コミットのハッシュ
  # $2 ファイルパス

  local diff=`git diff -U0 $1^..$1 -- $2 | tail -n +5 | grep -E "^(\+|-)"`
  # css のハッシュ変化は無視します。
  diff=`echo "${diff}" | grep -v "\/css\/app\.css"`
  return `[ -n "${diff}" ]`
}
