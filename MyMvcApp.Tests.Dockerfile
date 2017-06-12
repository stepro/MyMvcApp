FROM microsoft/aspnetcore-build
WORKDIR /src
COPY *.sln ./
COPY MyMvcApp/*.csproj MyMvcApp/
COPY MyMvcApp.Tests/*.csproj MyMvcApp.Tests/
COPY SharedLib/*.csproj SharedLib/
RUN dotnet restore MyMvcApp.Tests/MyMvcApp.Tests.csproj
COPY . .
WORKDIR MyMvcApp.Tests
CMD ["dotnet", "test"]
