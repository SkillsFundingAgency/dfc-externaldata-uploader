namespace BlobStorage
{
    public class BlobStorageSettings : IBlobStorageSettings
    {
        public string BlobStorageConnectionString { get; set; }
        public string BlobContainerName { get; set; }
    }
}
