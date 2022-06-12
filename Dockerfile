ARG PARENT_VERSION=1.2.14-dotnet6.0

FROM defradigital/dotnetcore-development:${PARENT_VERSION} AS development

# Install Sonar Scanner, Coverlet and Java (required for Sonar Scanner)
USER root
RUN apk --no-cache add openjdk11 --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community
USER dotnet
RUN dotnet tool install --global dotnet-sonarscanner && \
    dotnet tool install --global coverlet.console --version 1.7.2
ENV PATH="$PATH:/home/dotnet/.dotnet/tools"

# Map args to env vars
ARG PARENT_VERSION
ENV SONAR_HOST_URL https://sonarcloud.io
ENV SONAR_ORGANIZATION_KEY defra
ENV SONAR_PR_PROVIDER GitHub
ENV FIX_COVERAGE_REPORT true
ENV RUN_TESTS false

LABEL uk.gov.defra.ffc.parent-image=defradigital/dotnetcore-development:${PARENT_VERSION}

COPY --chown=dotnet:dotnet ./scripts .
RUN install -d -o dotnet -g dotnet /home/dotnet/project/ && \
    install -d -o dotnet -g dotnet /home/dotnet/working/

ENTRYPOINT [ "./run-analysis" ]
