using Microsoft.AspNetCore.Builder;
using System;
using System.Collections.Generic;
using System.Collections.Immutable;
using System.Linq;
using System.Threading.Tasks;

namespace pasionporlosbits.Middleware
{
    public static class HeaderRemoverExtensions
    {
        public static IApplicationBuilder UseHeaderRemover(this IApplicationBuilder builder, params string[] headersToRemove)
        {
            return builder.UseMiddleware<HeaderRemoverMiddleware>(headersToRemove.ToImmutableList());
        }
    }
}
