# Build Stage
#FROM microsoft/aspnetcore-build:2 AS build-env
#WORKDIR /api

#COPY api.csproj .
#RUN dotnet restore

#COPY . .
#RUN dotnet publish -o /publish

# Runtime Image Stage
#FROM microsoft/aspnetcore:2
#WORKDIR /publish
#COPY --from=build-env /publish .
#ENTRYPOINT ["dotnet", "api.dll"]

#FROM microsoft/aspnetcore:2.0-nanoserver-sac2016 AS build
#WORKDIR /prabaapi
#COPY ["bin/Debug/netcoreapp2.0/publish", "."]
#ENTRYPOINT ["dotnet", "/prabaapi/api.dll"]
#FROM microsoft/aspnetcore-build:2.0-nanoserver-sac2016 AS build
#old-ignore
#*
#!bin/Debug/netcoreapp2.0/publish

#Build Stage
FROM microsoft/aspnetcore-build:latest  AS build-env
WORKDIR /praba-api
COPY ["api.csproj", "."]
RUN dotnet restore
COPY [".", "."]
RUN dotnet publish -c Release -o /publish

#Runtime Stage
FROM microsoft/aspnetcore:2.0 AS runtime-env
WORKDIR /publish
COPY --from=build-env /publish .
ENTRYPOINT ["dotnet", "api.dll"]