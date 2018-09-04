FROM golang:1.10.4

ARG app_name=the-app
ARG package_name="any package"

ENV APP_NAME=${app_name}
ENV PACKAGE=${package_name}

RUN mkdir -p $GOPATH/src/$PACKAGE
WORKDIR $GOPATH/src/$PACKAGE/

COPY . .
COPY Gopkg.toml Gopkg.lock ./

RUN apt-get install curl
RUN curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

RUN dep ensure -vendor-only

RUN make install
ENTRYPOINT [ $APP_NAME ]

# EXPOSE 8000