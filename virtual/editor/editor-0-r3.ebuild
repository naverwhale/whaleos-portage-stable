# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Virtual for editor"

SLOT="0"
KEYWORDS="*"

# Add a package to RDEPEND only if the editor:
# - can edit ordinary text files,
# - works on the console,
# - is a "display" or "visual" editor (e.g., using ncurses).

RDEPEND="|| (
	app-editors/nano
	app-editors/dav
	app-editors/e3
	app-editors/ee
	app-editors/elvis
	app-editors/emacs:*
	app-editors/emact
	app-editors/ersatz-emacs
	app-editors/fe
	app-editors/jasspa-microemacs
	app-editors/jed
	app-editors/joe
	app-editors/jove
	app-editors/kakoune
	app-editors/le
	app-editors/levee
	app-editors/lpe
	app-editors/mg
	app-editors/moe
	app-editors/ne
	app-editors/neovim
	app-editors/ng
	app-editors/qemacs
	app-editors/teco
	app-editors/uemacs-pk
	app-editors/vile
	app-editors/vim
	app-editors/gvim
	app-editors/vis
	app-editors/xemacs
	app-editors/zile
	app-misc/mc[edit]
	dev-lisp/cmucl
	mail-client/alpine[-onlyalpine]
)"

# Packages outside app-editors providing an editor:
#	app-misc/mc: mcedit (#62643)
#	dev-lisp/cmucl: hemlock
#	mail-client/alpine: pico
#	sys-apps/busybox: vi
