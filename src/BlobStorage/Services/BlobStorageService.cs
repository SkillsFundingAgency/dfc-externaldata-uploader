using System;
using System.IO;
using Microsoft.Extensions.Options;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Blob;

namespace BlobStorage.Services
{
    public class BlobStorageService : IBlobStorageService
    {
        private readonly string _blobStorageConnectionString;
        private readonly string _blobContainerName;
        public BlobStorageService(IOptions<BlobStorageSettings> blobStorageSettings)
        {
            _blobStorageConnectionString = blobStorageSettings.Value.BlobStorageConnectionString;
            _blobContainerName = blobStorageSettings.Value.BlobContainerName;
        }

        public void StoreCsvToBlob(string csvFile)
        {
            try
            {
                CloudStorageAccount cloudStorageAccount = CloudStorageAccount.Parse(_blobStorageConnectionString);
                var y = new Uri(cloudStorageAccount.BlobStorageUri.PrimaryUri.AbsoluteUri + _blobContainerName);
                var x = new StorageUri(y);
                CloudBlobContainer cloudBlobContainer = new CloudBlobContainer(x, cloudStorageAccount.Credentials);

                //if (await cloudBlobContainer.CreateIfNotExistsAsync())
                //{
                //    await cloudBlobContainer.SetPermissionsAsync(
                //        new BlobContainerPermissions { PublicAccess = BlobContainerPublicAccessType.Blob });
                //}

                CloudBlockBlob cloudBlockBlob = cloudBlobContainer.GetBlockBlobReference("mahinder.csv");
                cloudBlockBlob.Properties.ContentType = "text/csv; charset=utf-8";
                cloudBlockBlob.UploadFromFile(csvFile);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void RetrieveCsvFromBlob()
        {
            CloudStorageAccount cloudStorageAccount = CloudStorageAccount.Parse(_blobStorageConnectionString);
            CloudBlobClient blobClient = cloudStorageAccount.CreateCloudBlobClient();

            CloudBlobContainer cloudBlobContainer = blobClient.GetContainerReference(_blobContainerName);
            CloudBlockBlob blockBlob = cloudBlobContainer.GetBlockBlobReference("mahinder.csv");

            using (var memoryStream = new MemoryStream())
            {
                blockBlob.DownloadToStream(memoryStream);
                var text = System.Text.Encoding.UTF8.GetString(memoryStream.ToArray());
                File.WriteAllText("filename goes here", text);
            }
        }
    }
}
