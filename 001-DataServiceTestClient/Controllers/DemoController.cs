using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using DataServiceClient.Models;

namespace DataServiceClient.Controllers
{
    public class DemoController : ApiController
    {
        DemoDataContext context = new DemoDataContext();
        // GET: api/Demo
        [HttpGet]
        public async Task<IEnumerable<DemoData>> Get()
        {
            return await context.GetList();
        }

        // GET: api/Demo/5
        public async Task<DemoData> Get(int id)
        {
            return await context.GetItem(id);
        }

    }
}
