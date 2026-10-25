if [ "${1:-}" = --help ]; then
  printf '%s\n' 'Prepare the routing-filter test bundle inside a disposable sandbox.' 'Optional inputs: REVIEW_GEM_CACHE and /deps/gem-archives.'
  exit 0
fi
# shellcheck source=/dev/null
source /workspace/nix/review/environment.sh
if [ -d /deps/gem-archives ]; then
  for archive in /deps/gem-archives/*.gem; do
    [ -f "$archive" ] || continue
    gem install --local --no-document --ignore-dependencies "$archive"
  done
fi
bundle check || bundle install --local
