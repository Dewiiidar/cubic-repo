using Application.DTOs;
using Application.Interfaces;
using Application.Services;
using AutoMapper;
using Core.Entities;
using Microsoft.AspNetCore.Mvc;

namespace Cubic.Controllers
{
    public class PriceController : Controller
    {
        private readonly IPriceService _priceService;
        private readonly IItemService _itemService;
        private readonly IMapper _mapper;

        public PriceController(IPriceService priceService, IMapper mapper, IItemService itemService)
        {
            _priceService = priceService;
            _mapper = mapper;
            _itemService = itemService;
        }

        public async Task<IActionResult> Index()
        {
            int Count = await _priceService.GetPricesCountAsync();
            ViewBag.Count = Count;
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Load(int draw, int start, int length, int count)
        {
            var data = await _priceService.GetAllPricesAsync(length, start);
            var dataModel = _mapper.Map<IEnumerable<PriceDTO>>(data);
            return Json(new { data = dataModel, draw = draw, recordsTotal = count, recordsFiltered = count });
        }

        public async Task<IActionResult> Add()
        {
            var model = new PriceDTO();
            return View(model);
        }

        [HttpPost]
        public async Task<IActionResult> Add(PriceDTO model)
        {
            if (ModelState.IsValid)
            {
                var price = _mapper.Map<Price>(model);
                int priceId = await _priceService.AddPriceAsync(price);
                if (priceId != 0)
                    TempData["Success"] = "Price added successfully.";
                return RedirectToAction("Index");
            }
            TempData["Error"] = "Error while adding the Price";
            return View(model);
        }

        [HttpGet]
        public async Task<JsonResult> SearchItems(string term)
        {
            if (string.IsNullOrWhiteSpace(term))
                return Json(new List<object>()); // return empty result for blank term

            var items = await _itemService.GetItemsByNameAsync(term);

            var result = items.Select(i => new
            {
                id = i.Id,
                name = i.Name
            });

            return Json(result);
        }
    }
}
