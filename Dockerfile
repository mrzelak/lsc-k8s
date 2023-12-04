FROM alpine:latest AS builder

WORKDIR /root
RUN apk add musl-dev \
	make \
	git \
	python3 \
	python3-dev \
	gcc 
RUN git clone https://github.com/aws/aws-cli -b v2
WORKDIR aws-cli
RUN ./configure --with-download-deps
RUN make
RUN make install

FROM alpine:latest
RUN apk add python3 make
COPY --from=builder /root/aws-cli /root/aws-cli
WORKDIR /root/aws-cli
RUN make install
#ENTRYPOINT ["aws"]
#CMD ["help"]
