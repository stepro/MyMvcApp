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
COPY . .

FROM base AS develop
EXPOSE 80
WORKDIR MyMvcApp
RUN dotnet build

FROM base AS publish
# Issue: WORKDIR inherited from develop image
WORKDIR /src
WORKDIR MyMvcApp
RUN dotnet publish -c Release -o /app

FROM microsoft/aspnetcore
EXPOSE 80
WORKDIR /app
COPY --from=publish /app .
CMD ["dotnet", "MyMvcApp.dll"]