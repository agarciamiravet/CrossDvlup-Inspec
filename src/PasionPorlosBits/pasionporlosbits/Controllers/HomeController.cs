using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using pasionporlosbits.Models;
using Microsoft.ApplicationInsights;
using Microsoft.AspNetCore.Authorization;
using System.Data.SqlClient;

namespace pasionporlosbits.Controllers
{
    public class HomeController : Controller
    {
        private TelemetryClient telemetry = new TelemetryClient();

        public IActionResult Index()
        {
            //telemetry.TrackEvent("Accediendo pagina principal");
            //telemetry.TrackPageView("HomePage");
            var fecha = DateTime.Now;

            ViewData["fecharelease"] = fecha.ToString(); ;

            return View();
        }

        [Authorize]
        public IActionResult About()
        {
            ViewData["Message"] = "Your application description page.";

            return View();
        }

        [Authorize]
        public IActionResult Login()
        {
            return View("Index");
        }

        public IActionResult Contact()
        {
            ViewData["Message"] = "Your contact page.";

            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

        public IActionResult CspReport(CspReportRequest report)
        {
            // TODO: log request to a datastore somewhere
           // _logger.LogWarning($"CSP Violation: {request.CspReport.DocumentUri}, {request.CspReport.BlockedUri}");

            return Ok();
        }
    }
}
