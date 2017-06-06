FROM my-mvc-app:develop AS develop
WORKDIR /src
COPY . .
WORKDIR MyMvcApp.Tests
