# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils gnome2

DESCRIPTION="Enjoy Twitch on your GNU/Linux desktop"
HOMEPAGE="http://gnome-twitch.vinszent.com/"

SRC_URI="https://github.com/vinszent/${PN}/archive/v${PV}.tar.gz"

LICENSE=""
SLOT="0"
IUSE=""

KEYWORDS="~amd64"

# FIXME: it uses clutter gst/gtk
# not sure what is actually used in the pipeline
# and how to cover it as deps
# probably need HLS at least,
RDEPEND="
	>=x11-libs/gtk+-3.20
	net-libs/libsoup:2.4
	dev-libs/json-glib

	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
	media-libs/gst-plugins-good:1.0
	media-libs/gst-plugins-bad:1.0

	media-libs/clutter-gst:3.0
	media-libs/clutter-gtk
	net-libs/webkit-gtk:4
"
DEPEND="${RDEPEND}
	>=dev-util/meson-0.32
	dev-util/ninja
"

src_configure() {

	mkdir ${S}/build
	cd ${S}/build

	# post install steps done by gnome2 eclass
	meson --prefix ${D}/usr -Ddo-post-install=false ..

}

src_install() {

	cd ${S}/build
	ninja install

}
