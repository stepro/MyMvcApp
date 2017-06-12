FROM microsoft/aspnetcore-build AS base
WORKDIR /src
COPY *.sln ./
COPY MyMvcApp/*.csproj MyMvcApp/
COPY SharedLib/*.csproj SharedLib/
RUN dotnet restore MyMvcApp/MyMvcApp.csproj
COPY . .

FROM base AS develop
EXPOSE 80
WORKDIR MyMvcApp
RUN dotnet build

FROM base AS publish
WORKDIR /src
WORKDIR MyMvcApp
RUN dotnet publish -c Release -o /app

FROM microsoft/aspnetcore
EXPOSE 80
WORKDIR /app
COPY --from=publish /app .
CMD ["dotnet", "MyMvcApp.dll"]
