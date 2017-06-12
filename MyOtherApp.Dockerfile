FROM microsoft/aspnetcore-build AS base
WORKDIR /src
COPY *.sln ./
# COPY --glob **/*.*proj ./
COPY MyMvcApp/MyMvcApp.csproj MyMvcApp/
COPY MyMvcApp.Tests/MyMvcApp.Tests.csproj MyMvcApp.Tests/
COPY MyOtherApp/MyOtherApp.csproj MyOtherApp/
COPY SharedLib/SharedLib.csproj SharedLib/
COPY WindowsFormsApplication1/WindowsFormsApplication1.csproj WindowsFormsApplication1/
RUN dotnet restore

FROM base AS develop
EXPOSE 80
COPY SharedLib SharedLib
RUN dotnet build SharedLib/SharedLib.csproj
WORKDIR MyOtherApp
COPY MyOtherApp .
RUN dotnet build

FROM base AS publish
# Issue: WORKDIR inherited from develop image
WORKDIR /src
COPY . .
WORKDIR MyOtherApp
RUN dotnet publish -c Release -o /app

FROM microsoft/aspnetcore
EXPOSE 80
WORKDIR /app
COPY --from=publish /app .
CMD ["dotnet", "MyOtherApp.dll"]