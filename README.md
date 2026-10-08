# homebrew-sprout

Homebrew tap for [Sprout](https://github.com/andy-watanabe/sprout), the menu bar
critter that shows how hard your Mac is working. Sprout used to be ClaudeMeter;
`formula_renames.json` moves existing `claudemeter` installs over on
`brew upgrade`.

```bash
brew tap andy-watanabe/sprout
brew install sprout
```

## Releasing an update

The formula is pinned to a git tag in the main repo, not to `main`'s HEAD, so
`brew upgrade` won't see new commits until the formula points at a new tag.
After pushing changes to `andy-watanabe/sprout`:

```bash
# In the sprout repo:
git tag vX.Y.Z
git push origin vX.Y.Z

# Get the new tarball's checksum:
curl -fsSL -o /tmp/sprout.tar.gz \
  https://github.com/andy-watanabe/sprout/archive/refs/tags/vX.Y.Z.tar.gz
shasum -a 256 /tmp/sprout.tar.gz

# In this repo, update Formula/sprout.rb's `url` and `sha256` to match,
# then commit and push.
```

Test before pushing:

```bash
brew reinstall --build-from-source sprout
sprout --dump
```
