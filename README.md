# Jack's Gossip Tap

## How do I install Gossip?
First add this tap
```bash
brew tap jacany/gossip
```

Then type the install command, note that this will install all dependencies needed to build gossip from the latest release.
```bash
brew install gossip
```
If you want to build from master, then run
```bash
brew install --HEAD gossip
```


You can also pass flags to this command to enable or disable different features
To disable video in case it's giving problems, run `brew install --without-video gossip`.
You can disable the Chinese, Japanese, and Korean language packs by also adding `--without-cjk`


## Support
If you are unable to build gossip with the install command, open an issue inside this repository.
