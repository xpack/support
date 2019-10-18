#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# This file is part of the xPacks distribution.
#   (https://xpack.github.io)
# Copyright (c) 2019 Liviu Ionescu.
#
# Permission to use, copy, modify, and/or distribute this software 
# for any purpose is hereby granted, under the terms of the MIT license.
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Safety settings (see https://gist.github.com/ilg-ul/383869cbb01f61a51c4d).

if [[ ! -z ${DEBUG} ]]
then
  set ${DEBUG} # Activate the expand mode if DEBUG is anything but empty.
else
  DEBUG=""
fi

set -o errexit # Exit if command failed.
set -o pipefail # Exit if pipe failed.
set -o nounset # Exit if variable not set.

# Remove the initial space and instead use '\n'.
IFS=$'\n\t'

# -----------------------------------------------------------------------------
# Identify the script location, to reach, for example, the helper scripts.

script_path="$0"
if [[ "${script_path}" != /* ]]
then
  # Make relative path absolute.
  script_path="$(pwd)/$0"
fi

script_folder_path="$(dirname "${script_path}")"
script_folder_name="$(basename "${script_folder_path}")"

# =============================================================================

node_path=$(which node)
npm_path=$(which npm)
if [ -n "${node_path}" -o -n "${npm_path}" ]
then
  echo "Uninstall node & npm before running this script."
  exit 1
fi

if [ $# -lt 1 ]
then
  echo "usage: sudo bash $(dirname "${script_path}") <version, like 10.16.0>"
  exit 1
fi

node_version=$0
shift

node_archive_name="node-v${node_version}-linux-x64.tar.xz"
if [ ! -f "~/Downloads/${node_archive_name}" ]
then
  curl --fail -L https://nodejs.org/dist/v${node_version}/${node_archive_name} -o "~/Downloads/${node_archive_name}.download"
  mv "~/Downloads/${node_archive_name}.download" "~/Downloads/${node_archive_name}"
fi

mkdir -p "/usr/local/lib/nodejs"
tar -xJvf "~/Downloads/${node_archive_name}" -C "/usr/local/lib/nodejs"

ln -s -v "/usr/local/lib/nodejs/node-v${node_version}-linux-x64/bin/node" "/usr/local/bin/node"
ln -s -v "/usr/local/lib/nodejs/node-v${node_version}-linux-x64/bin/npm" "/usr/local/bin/npm"
ln -s -v "/usr/local/lib/nodejs/node-v${node_version}-linux-x64/bin/npx" "/usr/local/bin/npx"

echo
echo "Done."