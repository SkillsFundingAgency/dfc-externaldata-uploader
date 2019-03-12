using System.Threading.Tasks;

namespace BlobStorage.Services
{
    public interface IBlobStorageService
    {
        void StoreCsvToBlob(string csvFile);
        void RetrieveCsvFromBlob();
    }
}
