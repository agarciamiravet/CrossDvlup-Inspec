﻿using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Collections.Immutable;
using System.Linq;
using System.Threading.Tasks;

namespace pasionporlosbits.Middleware
{
    public class HeaderRemoverMiddleware
    {

        private readonly RequestDelegate _next;
        private readonly ImmutableList<string> _headersToRemove;

        public HeaderRemoverMiddleware(RequestDelegate next, ImmutableList<string> headersToRemove)
        {
            _next = next;
            _headersToRemove = headersToRemove;
        }

        public async Task Invoke(HttpContext httpContext)
        {
            httpContext.Response.OnStarting(() =>
            {
                _headersToRemove.ForEach(header =>
                {
                    if (httpContext.Response.Headers.ContainsKey(header))
                    {
                        httpContext.Response.Headers.Remove(header);
                    }
                });

                return Task.FromResult(0);
            });

            await _next.Invoke(httpContext);
        }
    }
}
