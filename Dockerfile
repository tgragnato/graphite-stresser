FROM cgr.dev/chainguard/gradle:latest AS builder
WORKDIR /app
COPY build.gradle .
COPY src src
RUN gradle uberjar

FROM cgr.dev/chainguard/jre:latest
WORKDIR /app
COPY --from=builder /app/build/libs/graphite-stresser.jar graphite-stresser.jar
ENTRYPOINT ["java", "-jar", "graphite-stresser.jar"]
LABEL org.opencontainers.image.title="graphite-stresser"
LABEL org.opencontainers.image.description="A stress testing tool for Graphite"
LABEL org.opencontainers.image.url="https://github.com/tgragnato/graphite-stresser/"
LABEL org.opencontainers.image.source="https://github.com/tgragnato/graphite-stresser/"
LABEL license="BSD-3-Clause"
LABEL io.containers.autoupdate=registry
