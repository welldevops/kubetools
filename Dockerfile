FROM alpine as build
WORKDIR /tmp
RUN apk add --update -t deps curl tar gzip
RUN curl https://storage.googleapis.com/kubernetes-helm/helm-v2.11.0-linux-amd64.tar.gz | tar xz 
RUN curl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl -o ./kubectl

FROM alpine
WORKDIR /bin
COPY --from=build /tmp/linux-amd64/helm /bin/helm
COPY --from=build /tmp/kubectl /bin/kubectl
RUN chmod +x /bin/helm /bin/kubectl
CMD ["kubectl", "version"]
