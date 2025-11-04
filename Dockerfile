# Base stage (runtime environment)
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
WORKDIR /app
EXPOSE 8080
EXPOSE 8081

# Build stage
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["NepremicnineProjekt/NepremicnineProjekt.csproj", "NepremicnineProjekt/"]
RUN dotnet restore "NepremicnineProjekt/NepremicnineProjekt.csproj"
COPY . .
WORKDIR "/src/NepremicnineProjekt"
RUN dotnet build "NepremicnineProjekt.csproj" -c $BUILD_CONFIGURATION -o /app/build

# Publish stage
FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "NepremicnineProjekt.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

# Final stage (runtime image)
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .

ENTRYPOINT ["dotnet", "NepremicnineProjekt.dll"]
