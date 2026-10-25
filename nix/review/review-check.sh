if [ "${1:-}" = --help ]; then
  printf '%s\n' 'Run the complete routing-filter unit suite and review-shell checks.'
  exit 0
fi
# shellcheck source=/dev/null
source /workspace/nix/review/environment.sh
nixfmt --check flake.nix nix/review.nix
shellcheck -s bash nix/review/*.sh
bundle exec rake 2>&1 | tee /workspace/.review/unit.log
ruby -e 'text = File.read(ARGV[0]); abort "Pending or skipped unit tests" if text.match?(/[1-9][0-9]* (?:skips|pendings|omissions)/)' /workspace/.review/unit.log
