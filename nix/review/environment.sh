# shellcheck shell=bash
if [ "${REVIEW_SANDBOX:-}" != 1 ] || [ "$PWD" != /workspace ]; then
  printf '%s\n' 'Run review commands inside a disposable review sandbox.' >&2
  exit 64
fi
export TMPDIR=/workspace/.review/tmp
mkdir -p "$TMPDIR" /workspace/.review/gems
export GEM_HOME=/workspace/.review/gems
export GEM_PATH="$GEM_HOME${REVIEW_GEM_CACHE:+:$REVIEW_GEM_CACHE}"
export BUNDLE_IGNORE_CONFIG=1
unset BUNDLE_PATH BUNDLE_APP_CONFIG BUNDLE_WITHOUT
