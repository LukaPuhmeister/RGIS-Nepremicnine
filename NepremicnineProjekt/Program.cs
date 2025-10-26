var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/", () => Results.Content(@"
<!DOCTYPE html>
<html>
<head>
<title>Hello</title>
<style>
    body {
        background-color: #fafafa;
        display: flex;
        align-items: center;
        justify-content: center;
        height: 100vh;
        font-family: Arial, sans-serif;
        font-size: 48px;
        color: #333;
        margin: 0;
    }
</style>
</head>
<body>
Hello World :D
</body>
</html>
", "text/html")); // <-- pomembno!

app.Run();
