# This mail docker file used in teamcity
# Build stage
FROM microsoft/aspnetcore-build:latest AS build-env

WORKDIR /publish

# restore - 2 projects
COPY api/api.csproj ./api/
RUN dotnet restore api/api.csproj
COPY test/test.csproj ./test/
RUN dotnet restore test/test.csproj

# copy src
COPY . .

# test
#ENV TEAMCITY_PROJECT_NAME=fake
ENV TEAMCITY_PROJECT_NAME = ${TEAMCITY_PROJECT_NAME}
RUN dotnet test test/test.csproj

# publish
RUN dotnet publish api/api.csproj -o /publish

# Runtime stage
FROM microsoft/aspnetcore:2
COPY --from=build-env /publish /publish
WORKDIR /publish
ENTRYPOINT ["dotnet", "api.dll"]
