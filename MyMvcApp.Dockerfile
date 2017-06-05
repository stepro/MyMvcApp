FROM microsoft/aspnetcore-build AS base
WORKDIR /src
COPY *.sln ./
# Feature request: COPY glob pattern, maintain directory structure, e.g.
# COPY --glob --recursive */*.*proj ./
COPY MyMvcApp/*.csproj ./MyMvcApp/
COPY MyMvcApp.Tests/*.csproj ./MyMvcApp.Tests/
RUN dotnet restore
COPY . .
WORKDIR MyMvcApp

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
CMD ["dotnet", "MyMvcApp.dll"]
