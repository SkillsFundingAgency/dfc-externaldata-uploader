using System;
using System.IO;
using BlobStorage.Services;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace BlobStorage
{
    internal class Program
    {
        public static IConfiguration Configuration { get; set; }

        static void Main(string[] args)
        {
            Console.WriteLine("Enter the name of csv file to loaded to blob storage:");
            var csvFile = Console.ReadLine();

            var serviceProvider = ConfigureServices();

            var blobStorageService = serviceProvider.GetService<IBlobStorageService>();

            //blobStorageService.StoreCsvToBlob("C:\\CareersServiceDocuments\\ONSPD_NOV_2018_UK\\Data\\downloaded-mahinder.csv");
            blobStorageService.StoreCsvToBlob(csvFile);

            //blobStorageService.RetrieveCsvFromBlob();
        }

        public static ServiceProvider ConfigureServices()
        {
            var folder = Directory.GetCurrentDirectory();
            var builder = new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
                .AddEnvironmentVariables();

            Configuration = builder.Build();

            var services = new ServiceCollection();

            services.AddSingleton(Configuration);
            services.Configure<BlobStorageSettings>(Configuration.GetSection("BlobStorageSettings"));
            services.AddScoped<IBlobStorageService, BlobStorageService>();

            return services.BuildServiceProvider();
        }
    }
}
