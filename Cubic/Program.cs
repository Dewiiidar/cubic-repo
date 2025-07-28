using Application.Interfaces;
using Application.Mappings;
using Application.Services;
using AutoMapper;
using Core.Interfaces;
using InfraStructure.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;

var builder = WebApplication.CreateBuilder(args);
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<CubicContext>
    (x => x.UseMySql(connectionString, ServerVersion.AutoDetect(connectionString)));

builder.Services.AddAutoMapper(typeof(ItemProfile));
builder.Services.AddAutoMapper(typeof(PriceProfile));

builder.Services.AddScoped<IItemRepository,ItemRepository>();
builder.Services.AddScoped<IPriceRepository,PriceRepository>();


builder.Services.AddScoped<IItemService, ItemService>();
builder.Services.AddScoped<IPriceService, PriceService>();



// Add services to the container.
builder.Services.AddControllersWithViews();

var app = builder.Build();


using (var Scope = app.Services.CreateScope())
{
    var services = Scope.ServiceProvider;
    var loggerfactory = services.GetRequiredService<ILoggerFactory>();
    try
    {
        var context = services.GetRequiredService<CubicContext>();
        await context.Database.MigrateAsync();
        //  await CubicContextSeed.SeedAsync(context, loggerfactory);
    }
    catch (Exception ex)
    {
        var logger = loggerfactory.CreateLogger<Program>();
        logger.LogError(ex, " an Error Occured during Migration");
    }
}

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
