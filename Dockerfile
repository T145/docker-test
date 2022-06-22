FROM golang:1.17 AS go

# https://github.com/projectdiscovery/httpx#usage
# https://github.com/projectdiscovery/dnsx#usage
# https://github.com/ipinfo/cli#-ipinfo-cli
# https://github.com/StevenBlack/ghosts#ghosts
RUN go install github.com/projectdiscovery/dnsx/cmd/dnsx@latest \
    && go install github.com/projectdiscovery/httpx/cmd/httpx@latest \
    && go install github.com/ipinfo/cli/ipinfo@latest
    # && go install github.com/StevenBlack/ghosts@latest

# production image
FROM ubuntu:impish

LABEL maintainer="T145" \
      version="1.0.0" \
      description="An unstable image used to experiment with Docker."

COPY --from=go /usr/local/go/ /usr/local/
COPY --from=go /go/ /go/

# set go env path
# https://www.digitalocean.com/community/tutorials/how-to-install-go-and-set-up-a-local-programming-environment-on-ubuntu-18-04
ENV GOPATH=/go
ENV PATH=$PATH:$GOPATH/bin:/usr/local/go/bin
