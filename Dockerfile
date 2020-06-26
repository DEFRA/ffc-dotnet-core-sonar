ARG PARENT_VERSION=1.0.1-dotnet3.1

FROM defradigital/dotnetcore-development:${PARENT_VERSION} AS development
ARG PARENT_VERSION
LABEL uk.gov.defra.ffc.parent-image=defradigital/dotnetcore-development:${PARENT_VERSION}

COPY --chown=dotnet:dotnet ./scripts .

ENTRYPOINT [ "./run-analysis" ] 
