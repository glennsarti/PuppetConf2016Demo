using System;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;

namespace puppetconf2016
{
    public class Startup
    {
        public void Configure(IApplicationBuilder app)
        {
            app.Run(context =>
            {
                return context.Response.WriteAsync("<html><head><style> body { background-color: #212221; color:white; font-family:Tahoma; }</style></head><body><table border='0'><tr><td><img src='http://192.168.200.199/pup_logo.png'" + 
                                                   "width='361' height='402'/></td><td><span style='font-size:32pt;'>Hello from Puppet Conf!<br/>" + DateTime.Now.ToString("h:mm:ss tt, d MMM yyyy") + "</span></td></tr></table></body></html>");
            });
        }
    }
}
