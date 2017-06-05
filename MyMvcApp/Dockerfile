FROM microsoft/aspnetcore-build AS base
WORKDIR /src
COPY *.csproj ./
RUN dotnet restore
COPY . .

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
