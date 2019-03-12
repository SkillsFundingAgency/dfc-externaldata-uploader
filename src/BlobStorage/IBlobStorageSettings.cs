namespace BlobStorage
{
    public interface IBlobStorageSettings
    {
        string BlobStorageConnectionString { get; }
        string BlobContainerName { get; }
    }
}
