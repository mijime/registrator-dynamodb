FROM gliderlabs/alpine:3.1
ENTRYPOINT ["/bin/registrator"]

RUN apk-install -t build-deps go git mercurial \
	&& mkdir -p /go/src/github.com/gliderlabs \
	&& git clone https://github.com/gliderlabs/registrator /go/src/github.com/gliderlabs/registrator \
	&& cd /go/src/github.com/gliderlabs/registrator \
	&& export GOPATH=/go \
	&& sed -ie '4a _ "github.com/mijime/registrator-dynamodb"' modules.go \
	&& go get \
	&& go build -ldflags "-X main.Version $(cat VERSION)" -o /bin/registrator \
	&& rm -rf /go \
	&& apk del --purge build-deps
