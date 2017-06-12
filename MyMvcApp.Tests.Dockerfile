FROM microsoft/aspnetcore-build
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
WORKDIR MyMvcApp.Tests
CMD ["dotnet", "test"]