﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
using SharedLib;

namespace MyMvcApp
{
    public class Program
    {
        public static string Test = "pass";

        public static void Main(string[] args)
        {
            Console.WriteLine(SharedLib.Class1.Message);
            
            var host = new WebHostBuilder()
                .UseKestrel()
                .UseContentRoot(Directory.GetCurrentDirectory())
                .UseIISIntegration()
                .UseStartup<Startup>()
                .Build();

            host.Run();
        }
    }
}
