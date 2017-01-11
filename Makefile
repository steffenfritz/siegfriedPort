# Created by: Steffen Fritz <steffen@fritz.wtf>
# $FreeBSD$

PORTNAME=			siegfried
PORTVERSION=		1.6.7
DISTVERSIONPREFIX=	v
CATEGORIES=			sysutils

MAINTAINER=			steffen@fritz.wtf
COMMENT= 			File identification tool

LICENSE=			APACHE20

BUILD_DEPENDS=  	go:lang/go

PLIST_FILES=		bin/siegfried

USE=				go
USE_GITHUB=			yes
GH_ACCOUNT=			richardlehane

STRIP=

post-extract:
	@${MV} ${WRKSRC}/vendor ${WRKSRC}/src
	@${MKDIR} ${WRKSRC}/src/github.com/${GH_ACCOUNT}/${PORTNAME}
.for src in .gitattributes README.md config glide.lock pkg siegfried_test.go \
	.travis.yml cmd debian glide.yaml siegfried.go
	@${MV} ${WRKSRC}/${src} \
		${WRKSRC}/src/github.com/${GH_ACCOUNT}/${PORTNAME}
.endfor

do-build:
	@cd ${WRKSRC}/src/github.com/${GH_ACCOUNT}/${PORTNAME}/cmd/sf; ${SETENV} GOPATH=${WRKSRC} go build -o ${WRKSRC}/${GH_ACCOUNT}/${PORTNAME}/bin/siegfried

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/${GH_ACCOUNT}/${PORTNAME}/bin/siegfried ${STAGEDIR}${PREFIX}/bin/siegfried

post-install:
	@${ECHO_MSG}    ""
	@${ECHO_MSG}    "  You should run 'siegfried -update' to update your local PRONOM database."
	@${ECHO_MSG}    ""

.include <bsd.port.mk>
