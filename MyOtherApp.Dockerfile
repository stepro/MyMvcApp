FROM my-mvc-app:develop AS develop
WORKDIR /src
COPY . .
WORKDIR MyOtherApp
RUN dotnet build -v n

FROM develop AS publish
RUN dotnet publish -c Release -o /app

FROM microsoft/aspnetcore
EXPOSE 80
WORKDIR /app
COPY --from=publish /app .
CMD ["dotnet", "MyOtherApp.dll"]
