ARG PARENT_VERSION=1.0.1-dotnet3.1

FROM defradigital/dotnetcore-development:${PARENT_VERSION} AS development
ARG PARENT_VERSION
LABEL uk.gov.defra.ffc.parent-image=defradigital/dotnetcore-development:${PARENT_VERSION}

# Install Sonar Scanner, Coverlet and Java (required for Sonar Scanner)
USER root
RUN apk --no-cache add openjdk11 --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community
RUN dotnet tool install --global dotnet-sonarscanner
RUN dotnet tool install --global coverlet.console
ENV PATH="$PATH:/root/.dotnet/tools"
USER dotnet

RUN mkdir -p /home/dotnet/project/
COPY --chown=dotnet:dotnet ./scripts .

ENTRYPOINT [ "./run-analysis" ] 
