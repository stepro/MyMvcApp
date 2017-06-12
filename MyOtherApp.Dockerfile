FROM microsoft/aspnetcore-build AS base
WORKDIR /src
COPY *.sln ./
COPY MyOtherApp/*.csproj MyOtherApp/
COPY SharedLib/*.csproj SharedLib/
RUN dotnet restore MyOtherApp/MyOtherApp.csproj

FROM base AS develop
EXPOSE 80
COPY SharedLib SharedLib
RUN dotnet build SharedLib/SharedLib.csproj
WORKDIR MyOtherApp
COPY MyOtherApp .
RUN dotnet build

FROM base AS publish
WORKDIR /src
COPY . .
WORKDIR MyOtherApp
RUN dotnet publish -c Release -o /app

FROM microsoft/aspnetcore
EXPOSE 80
WORKDIR /app
COPY --from=publish /app .
CMD ["dotnet", "MyOtherApp.dll"]
