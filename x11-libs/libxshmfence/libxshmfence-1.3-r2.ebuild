# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

XORG_MULTILIB=yes
inherit xorg-3

DESCRIPTION="Shared memory fences using futexes"

KEYWORDS="*"

DEPEND="x11-base/xorg-proto"
