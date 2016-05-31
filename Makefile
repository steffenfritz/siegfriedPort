# $FreeBSD$

PORTNAME=		siegfried
PORTVERSION=		1.5.0
DISTVERSIONPREFIX=	v
CATEGORIES=		sysutils

MAINTAINER=		steffen@fritz.wtf
COMMENT= 		a file identification tool

PLIST_FILES=		bin/siegfried

LICENSE=		APACHE20

BUILD_DEPENDS=  	go:lang/go

USE_GITHUB=		yes
GH_ACCOUNT=		richardlehane

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
	${INSTALL_PROGRAM} ${WRKSRC}/${GH_ACCOUNT}/${PORTNAME}/bin/siegfried ${PREFIX}/bin/siegfried

.include <bsd.port.mk>