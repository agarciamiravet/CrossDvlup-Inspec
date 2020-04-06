using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using pasionporlosbits.Models;

namespace pasionporlosbits.Controllers
{
    

    [ApiController]
    public class HcController : ControllerBase
    {
        private readonly IConfiguration configuration;


        public HcController(IConfiguration configuration)
        {
            this.configuration = configuration;
        }

        [Route("api/hc/vault")]
        public async Task<string> ReadVault()
        {
            return this.configuration["pasionkey"];
        }

        [Route("api/hc/local")]
        public async Task<string> ReadLocal()
        {
            return this.configuration["KeyVaultName"];
        }

        [Route("api/hc/status")]
        public StatusViewModel Checkhealth()
        {
            return new StatusViewModel { Status = "successful" };
        }
    }
}