using System;
using System.IdentityModel.Tokens.Jwt;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using pasionporlosbits.Middleware;
using Serilog;
using Serilog.Events;
using Serilog.Sinks.Elasticsearch;

namespace pasionporlosbits
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            // Create Serilog Elasticsearch logger
            Log.Logger = new LoggerConfiguration()
               .Enrich.FromLogContext()
               .MinimumLevel.Debug()
               .WriteTo.Elasticsearch(new ElasticsearchSinkOptions(new Uri("http://localhost:9200"))
               {
                   MinimumLogEventLevel = LogEventLevel.Verbose,
                   AutoRegisterTemplate = true
               })
               .CreateLogger();

            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddLogging(loggingBuilder => loggingBuilder.AddSerilog(dispose: true));
            services.AddMvc();

            JwtSecurityTokenHandler.DefaultInboundClaimTypeMap.Clear();

            services.AddAuthentication(options =>
            {
                options.DefaultScheme = "Cookies";
                options.DefaultChallengeScheme = "oidc";
            })
               .AddCookie(options =>
               {
                   options.Cookie.Name = "CookieBuena";
               })
                .AddOpenIdConnect("oidc", options =>
                {
                    options.CorrelationCookie.Name = "Correlation";
                    options.NonceCookie.Name = "Nonce";

                    options.SignInScheme = "Cookies";

                    options.Authority = "https://login.pasionporlosbits.com";
                    options.RequireHttpsMetadata = false;

                    options.ClientId = "mvc";
                    options.ClientSecret = "secret";
                    options.ResponseType = "code id_token";

                    options.SaveTokens = true;
                    options.GetClaimsFromUserInfoEndpoint = true;

                    options.Scope.Add("api1");
                    options.Scope.Add("offline_access");

                    options.ClaimActions.MapJsonKey("website", "website");
                });
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env, ILoggerFactory loggerFactory)
        {
            loggerFactory.AddConsole(Configuration.GetSection("Logging"));
            loggerFactory.AddDebug();

            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
            }

            app.UseXXssProtection(options => options.EnabledWithBlockMode());

         
            app.UseHsts(h => h.MaxAge(days: 365));


            //31536000

            app.UseXContentTypeOptions();

            app.UseHeaderRemover("Server");

            app.UseAuthentication();

            app.UseStatusCodePagesWithReExecute("/Home/Error", "?statusCode={0}");

            app.UseStaticFiles();

            app.UseCsp(opts => opts
            .BlockAllMixedContent()
            .StyleSources(s => s.Self())
            .StyleSources(s => s.UnsafeInline().CustomSources("fonts.googleapis.com"))
            .FontSources(s => s.Self().CustomSources("fonts.gstatic.com"))
            .FormActions(s => s.Self())
            .FrameAncestors(s => s.Self())
            .ImageSources(s => s.Self())
            .ScriptSources(s => s.Self()).ReportUris(r => r.Uris("/home/cspreport")));


            //app.UseCsp(options => options
            //.DefaultSources(s => s.Self())
            //.ScriptSources(s => s.Self().UnsafeInline())
            //.FontSources(s => s.Self().CustomSources("https://fonts.googleapis.com")));  

            app.UseMvc(routes =>
            {
                routes.MapRoute(
                    name: "default",
                    template: "{controller=Home}/{action=Index}/{id?}");
            });
        }
    }
}

