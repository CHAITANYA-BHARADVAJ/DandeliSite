$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:8080/")
$listener.Start()
Write-Host "Started HTTP server on http://localhost:8080/"

while ($listener.IsListening) {
    $context = $listener.GetContext()
    $response = $context.Response
    
    $localPath = [uri]::UnescapeDataString($context.Request.Url.LocalPath)
    if ($localPath -eq "/") { $localPath = "/index.html" }
    $filePath = Join-Path $PWD $localPath.Replace('/', '\')
    
    if (Test-Path $filePath -PathType Leaf) {
        try {
            # Basic mime types
            $ext = [System.IO.Path]::GetExtension($filePath).ToLower()
            $mime = "application/octet-stream"
            if ($ext -eq ".html" -or $ext -eq ".htm") { $mime = "text/html" }
            elseif ($ext -eq ".css") { $mime = "text/css" }
            elseif ($ext -eq ".js") { $mime = "application/javascript" }
            elseif ($ext -eq ".jpg" -or $ext -eq ".jpeg") { $mime = "image/jpeg" }
            elseif ($ext -eq ".png") { $mime = "image/png" }
            
            $response.ContentType = $mime
            
            # Write file content
            $stream = [System.IO.File]::OpenRead($filePath)
            $response.ContentLength64 = $stream.Length
            $stream.CopyTo($response.OutputStream)
            $stream.Close()
        } catch {
            $response.StatusCode = 500
        }
    } else {
        $response.StatusCode = 404
    }
    $response.Close()
}
