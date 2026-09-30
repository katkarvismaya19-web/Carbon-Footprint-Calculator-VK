Write-Host "====================================="
Write-Host " Carbon Footprint Health Check"
Write-Host "====================================="

Write-Host "
[1] Java"
java -version

Write-Host "
[2] Docker"
docker --version

Write-Host "
[3] Docker containers"
docker ps

Write-Host "
[4] Tomcat port"
netstat -ano | findstr :8081

Write-Host "
[5] Application"
try {
    $response = Invoke-WebRequest 
        -Uri "http://localhost:8081/carbon-footprint-calculator/" 
        -UseBasicParsing 
        -TimeoutSec 10

    Write-Host "Application HTTP Status:" $response.StatusCode
}
catch {
    Write-Host "Application health check failed"
}
