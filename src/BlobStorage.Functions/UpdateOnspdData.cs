using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using Microsoft.Azure.WebJobs;
using Microsoft.Extensions.Logging;

namespace BlobStorage.Functions
{
    public static class UpdateOnspdData
    {
        [FunctionName("UpdateOnspdData")]
        public static void Run([BlobTrigger("onspd-blob-container/{name}", Connection = "StorageConnection")]Stream myBlob, string name, ILogger log)
        {
            log.LogInformation($"C# Blob trigger function Processed blob\n Name:{name} \n Size: {myBlob.Length} Bytes");

            // trigger the sql proc which will trigger the package

            // Get Connection strings(put local and Azure env together)
            var connParameter = "DefaultConnection";
            var Prefix = "SQLAZURECONNSTR_";
            var connectionString = System.Environment.GetEnvironmentVariable($"ConnectionStrings:{connParameter}");
            if (string.IsNullOrEmpty(connectionString))
            {
                connectionString = System.Environment.GetEnvironmentVariable($"{Prefix}{connParameter}");
            }

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (var cmd = new SqlCommand("[dfc-coursedirectory].[dbo].[dfc_OnspdExecuteSsisPackage]", conn)
                {
                    CommandType = CommandType.StoredProcedure
                })
                {
                    var updatedDateTimeParam = new SqlParameter
                    {
                        Value = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day),
                        DbType = DbType.DateTime,
                        Direction = ParameterDirection.Input,
                        ParameterName = "@updated",
                        SqlDbType = SqlDbType.DateTime
                    };

                    var outputParameter = new SqlParameter()
                    {
                        Value = null,
                        DbType = DbType.Int64,
                        ParameterName = "@output_execution_id",
                        SqlDbType = SqlDbType.BigInt,
                        Direction = ParameterDirection.Output
                    };

                    cmd.Parameters.Add(updatedDateTimeParam);
                    cmd.Parameters.Add(outputParameter);
                    cmd.ExecuteNonQuery();
                }
            }
        }
    }
}
