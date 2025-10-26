FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80
ENV ASPNETCORE_URLS=http://+:80

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["NepremicnineProjekt/NepremicnineProjekt.csproj", "NepremicnineProjekt/"]
RUN dotnet restore "NepremicnineProjekt/NepremicnineProjekt.csproj"
COPY . .
WORKDIR "/src/NepremicnineProjekt"
RUN dotnet build "NepremicnineProjekt.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "NepremicnineProjekt.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "NepremicnineProjekt.dll"]
