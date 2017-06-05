FROM microsoft/aspnetcore-build
WORKDIR /src
COPY *.sln ./
# Feature request: COPY glob pattern, maintain directory structure, e.g.
# COPY --glob --recursive */*.*proj ./
COPY MyMvcApp/*.csproj ./MyMvcApp/
COPY MyMvcApp.Tests/*.csproj ./MyMvcApp.Tests/
RUN dotnet restore
COPY . .
WORKDIR MyMvcApp.Tests
CMD ["dotnet", "test"]
