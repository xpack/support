# Support files

## `scripts/reinstall-linux-node.sh`

A script to reinstall an official node from https://nodejs.org/en/download/.

Usage:

```console
$ bash reinstall-linux-node.sh <version>
```

Example:

```console
$ curl --fail -L https://github.com/xpack/support/raw/master/scripts/reinstall-linux-node.sh -o ~/Downloads/reinstall-linux-node.sh
$ bash ~/Downloads/reinstall-linux-node.sh 10.16.3
```

Be sure you uninstall `node` and `npm` before running this script.
