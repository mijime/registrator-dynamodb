FROM gliderlabs/alpine:3.3
ENTRYPOINT ["/bin/registrator"]

ADD . /go/src/github.com/mijime/registrator-dynamodb

RUN apk-install -t build-deps go git mercurial \
	&& mkdir -p /go/src/github.com/gliderlabs \
	&& git clone https://github.com/gliderlabs/registrator /go/src/github.com/gliderlabs/registrator \
	&& cd /go/src/github.com/gliderlabs/registrator \
	&& export GOPATH=/go \
	&& cp /go/src/github.com/mijime/registrator-dynamodb/modules.go modules.go \
	&& go get \
	&& go build -ldflags "-X main.Version=$(cat VERSION)-dynamodb" -o /bin/registrator \
	&& rm -rf /go \
	&& apk del --purge build-deps
