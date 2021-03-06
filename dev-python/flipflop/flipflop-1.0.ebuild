# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=(python3_{3,4})

inherit distutils-r1

DESCRIPTION="A FastCGI/WSGI gateway"
HOMEPAGE="https://github.com/Kozea/flipflop"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
