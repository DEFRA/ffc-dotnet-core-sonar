ARG PARENT_VERSION=1.0.1-dotnet3.1
ARG SONAR_HOST_URL=https://sonarcloud.io
ARG SONAR_OGRANIZAION_KEY=defra
ARG SONAR_PROJECT_KEY
ARG SONAR_TOKEN
ARG SONAR_PR_PROVIDER=GitHub
ARG SONAR_PR_REPOSITORY
ARG SONAR_PR_KEY
ARG SONAR_PR_BRANCH

FROM defradigital/dotnetcore-development:${PARENT_VERSION} AS development

# Map args to env vars
ARG PARENT_VERSION
ENV PARENT_VERSION ${PARENT_VERSION}
ARG SONAR_HOST_URL
ENV SONAR_HOST_URL ${SONAR_HOST_URL}
ARG SONAR_ORGANIZAION_KEY
ENV SONAR_ORGANIZAION_KEY ${SONAR_ORGANIZAION_KEY}
ARG SONAR_PROJECT_KEY
ENV SONAR_PROJECT_KEY ${SONAR_PROJECT_KEY}
ARG SONAR_TOKEN
ENV SONAR_TOKEN ${SONAR_TOKEN}}
ARG SONAR_PR_PROVIDER
ENV SONAR_PR_PROVIDER ${SONAR_PR_PROVIDER}
ARG SONAR_PR_REPOSITORY
ENV SONAR_PR_REPOSITORY ${SONAR_PR_REPOSITORY}
ARG SONAR_PR_KEY
ENV SONAR_PR_KEY ${SONAR_PR_KEY}
ARG SONAR_PR_BRANCH
ENV SONAR_PR_BRANCH ${SONAR_BRANCH}

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
