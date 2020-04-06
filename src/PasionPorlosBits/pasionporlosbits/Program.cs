using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Azure.KeyVault;
using Microsoft.Azure.Services.AppAuthentication;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Configuration.AzureKeyVault;
using Microsoft.Extensions.Logging;

namespace pasionporlosbits
{
    public class Program
    {
        public static void Main(string[] args)
        {
            CreateWebHostBuilder(args).UseUrls("http://localhost:5002/").Build().Run();
        }

        public static IWebHostBuilder CreateWebHostBuilder(string[] args) =>
            WebHost.CreateDefaultBuilder(args)
                .UseKestrel(options => options.AddServerHeader = false )
                .UseStartup<Startup>()
                .UseApplicationInsights()
                .ConfigureAppConfiguration((context, config) =>
                {
                    if (context.HostingEnvironment.IsProduction())
                    {
                        var builtConfig = config.Build();

                       // var azureServiceTokenProvider = new AzureServiceTokenProvider();
                      //  var keyVaultClient = new KeyVaultClient(
                       //     new KeyVaultClient.AuthenticationCallback(
                       //         azureServiceTokenProvider.KeyVaultTokenCallback));

                       // config.AddAzureKeyVault(
                         //   $"https://{builtConfig["KeyVaultName"]}.vault.azure.net/",
                         //   keyVaultClient,
                          //  new DefaultKeyVaultSecretManager());
                    }
                }); // Enable Application Insights
    }
}
