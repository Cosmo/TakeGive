// --------------------------------------------------------------------------------------------------------------------
// <copyright file="DatabaseSetup.cs" company="TakeGive.eu">
//   TakeGive.eu
// </copyright>
// <summary>
//   Defines the DatabaseSetup type.
// </summary>
// --------------------------------------------------------------------------------------------------------------------

namespace TakeGive.MongoDb
{
    using Microsoft.WindowsAzure.ServiceRuntime;

    using MongoDB.Driver;

    public static class DatabaseSetup
    {
        public static void Run()
        {
            var connectionString = RoleEnvironment.GetConfigurationSettingValue("MongoDbConnectionString");
            var database = MongoDatabase.Create(connectionString);
            var collection = database.GetCollection("item");
            
            var result = collection.CreateIndex("keywords");
        }
    }
}
