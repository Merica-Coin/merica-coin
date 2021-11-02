#!/usr/bin/env bash
# Copyright (c) 2016-2019 The Bitcoin Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

MERICAD=${MERICAD:-$BINDIR/mericad}
MERICACLI=${MERICACLI:-$BINDIR/merica-cli}
MERICATX=${MERICATX:-$BINDIR/merica-tx}
WALLET_TOOL=${WALLET_TOOL:-$BINDIR/merica-wallet}
MERICAQT=${MERICAQT:-$BINDIR/qt/merica-qt}

[ ! -x $MERICAD ] && echo "$MERICAD not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
read -r -a MERICAVER <<< "$($MERICACLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }')"

# Create a footer file with copyright content.
# This gets autodetected fine for mericad if --version-string is not set,
# but has different outcomes for merica-qt and merica-cli.
echo "[COPYRIGHT]" > footer.h2m
$MERICAD --version | sed -n '1!p' >> footer.h2m

for cmd in $MERICAD $MERICACLI $MERICATX $WALLET_TOOL $MERICAQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${MERICAVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${MERICAVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
