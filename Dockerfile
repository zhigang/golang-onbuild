FROM golang:1.9

LABEL maintainer="siriuszg <zhigang52110@sina.com>"

# setup swagger-ui
ENV SWAGGER_UI_VERSION=3.13.4
RUN mkdir -p /swagger-ui && \
    curl -fsSL https://github.com/swagger-api/swagger-ui/archive/v$SWAGGER_UI_VERSION.tar.gz | tar xzC / && \
    mv /swagger-ui-$SWAGGER_UI_VERSION/dist/* /swagger-ui/
ONBUILD ARG SWAGGER_PATH=/swagger
ONBUILD RUN sed -i "s|http://petstore.swagger.io/v2/swagger.json|$SWAGGER_PATH|g" /swagger-ui/index.html && \
    sed -i "s|http://example.com/api|$SWAGGER_PATH|g" /swagger-ui/index.html

# go get -u golang.org/x/net/...
RUN git clone https://github.com/golang/net.git $GOPATH/src/golang.org/x/net

# go get -u golang.org/x/crypto/...
RUN git clone https://github.com/golang/crypto.git $GOPATH/src/golang.org/x/crypto

# install packages
RUN go get -u go.uber.org/zap \
    && go get -u golang.org/x/oauth2 \
    && go get -u gopkg.in/mgo.v2 \
    && go get -u gopkg.in/yaml.v2 \
    && go get -u google.golang.org/grpc