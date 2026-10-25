# Isolated review shell

Select `devShells.review` in the sandbox runner. The default developer shell is unchanged, and the review shell does not run a shell hook.

Run `review-bootstrap`, then `review-check`. The runner must use `/workspace` and set `REVIEW_SANDBOX=1`; both commands refuse to change a host checkout. Use `--help` to inspect the commands without setup.

An installed Ruby bundle can be supplied read-only through `REVIEW_GEM_CACHE`. Missing public gem archives can be supplied at `/deps/gem-archives`. Installation is local-only inside the disposable workspace. No host credentials or network access are required.

The check runs the complete unit suite and checks the review shell files. Keep test results and workspace changes in the runner's local artifacts before cleanup.
