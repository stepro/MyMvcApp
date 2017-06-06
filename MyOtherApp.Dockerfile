FROM microsoft/aspnetcore-build AS base
WORKDIR /src
COPY *.sln ./
# Feature request: COPY glob pattern, maintain directory structure, e.g.
# COPY --glob --recursive */*.*proj ./
COPY MyOtherApp/*.csproj ./MyOtherApp/
COPY SharedLib/*.csproj ./SharedLib/
RUN dotnet restore
COPY . .
WORKDIR MyOtherApp

FROM base AS develop
EXPOSE 80
ENV ASPNETCORE_ENVIRONMENT Development
RUN dotnet build
CMD ["dotnet", "run"]

FROM base AS publish
RUN dotnet publish -c Release -o /app

FROM microsoft/aspnetcore AS production
EXPOSE 80
WORKDIR /app
COPY --from=publish /app .
CMD ["dotnet", "MyOtherApp.dll"]
