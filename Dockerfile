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

# install x packages
RUN go get -u golang.org/x/crypto/... \
    && go get -u golang.org/x/crypto/... \
    && go get -u golang.org/x/sys/... \
    && go get -u golang.org/x/oauth2

# install go packages
RUN go get go.uber.org/zap \
    && go get gopkg.in/mgo.v2 \
    && go get gopkg.in/yaml.v2 \
    && go get google.golang.org/grpc