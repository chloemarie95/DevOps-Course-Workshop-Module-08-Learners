FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build 
WORKDIR /source

RUN apt-get update -yq 
RUN apt-get install curl -yq

RUN curl -fsSL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs

# copy csproj and restore as distinct layers
COPY *.csproj .
# copy and publish app and libraries
COPY . .
RUN dotnet build

WORKDIR /source/DotnetTemplate.Web
RUN npm install
RUN npm run build 

ENTRYPOINT [ "dotnet", "run" ]