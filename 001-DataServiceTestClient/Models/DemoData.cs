using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net.Http;
using System.Threading.Tasks;
using System.Net.Http.Headers;

namespace DataServiceClient.Models
{
    public class DemoDataContext
    {
        private string url = "http://serviceHost:8080/";
        HttpClient client = new HttpClient();

        public DemoDataContext()
        {
            client.BaseAddress = new Uri(url);
            client.DefaultRequestHeaders.Accept.Clear();
            client.DefaultRequestHeaders.Accept.Add(
                new MediaTypeWithQualityHeaderValue("application/json"));

        }
        public async Task<List<DemoData>> GetList()
        {
            List<DemoData> result = null;
            var response = await client.GetAsync("users");
            if (response.IsSuccessStatusCode)
            {
                result = Newtonsoft.Json.JsonConvert.DeserializeObject<List<DemoData>>(await response.Content.ReadAsStringAsync());
            }
            return result;
        }
        public async Task<DemoData> GetItem(int id)
        {
            DemoData result = null;
            var response = await client.GetAsync($"users/{id}");
            if (response.IsSuccessStatusCode)
            {
                result = Newtonsoft.Json.JsonConvert.DeserializeObject<DemoData>(await response.Content.ReadAsStringAsync());
            }
            return result;

        }
    }
    public class DemoData
    {
        public int id { get; set; }
        public string firstName { get; set; }
        public string lastName { get; set; }
    }
}