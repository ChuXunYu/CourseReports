$ErrorActionPreference = "Stop"

$containerName = "course-assets-pg"
$imageName = "postgres:16"

$env:JAVA_HOME = "E:\Scoop\apps\temurin17-jdk\current"
$env:PATH = "E:\Scoop\shims;E:\Scoop\apps\temurin17-jdk\current\bin;" + $env:PATH
$env:KINGBASE_URL = "jdbc:kingbase8://localhost:54321/course_assets"
$env:KINGBASE_USERNAME = "system"
$env:KINGBASE_PASSWORD = "manager"

Write-Host "Checking Docker daemon..."
docker version | Out-Null

$imageExists = docker images --format "{{.Repository}}:{{.Tag}}" | Select-String "^${imageName}$"
if (-not $imageExists) {
    Write-Host "Pulling $imageName ..."
    docker pull $imageName | Out-Host
}

$containerExists = docker ps -a --format "{{.Names}}" | Select-String "^${containerName}$"
if ($containerExists) {
    Write-Host "Removing existing container $containerName ..."
    docker rm -f $containerName | Out-Null
}

Write-Host "Starting compatibility database container on localhost:54321 ..."
docker run -d `
    --name $containerName `
    -e POSTGRES_USER=system `
    -e POSTGRES_PASSWORD=manager `
    -e POSTGRES_DB=course_assets `
    -p 54321:5432 `
    $imageName | Out-Null

Write-Host "Waiting for database readiness ..."
$isReady = $false
for ($i = 0; $i -lt 30; $i++) {
    $ready = docker exec $containerName pg_isready -U system -d course_assets 2>$null
    if ($LASTEXITCODE -eq 0) {
        $isReady = $true
        break
    }
    Start-Sleep -Seconds 2
}

if (-not $isReady) {
    throw "Database did not become ready on localhost:54321."
}

Write-Host "Database is ready on localhost:54321."
Write-Host "Run the Spring Boot app manually when needed:"
Write-Host "  mvn spring-boot:run"
