using Application.DTOs;
using Application.Interfaces;
using AutoMapper;
using Core.Entities;
using Core.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace Cubic.Controllers
{
    public class ItemController : Controller
    {
        private readonly IItemService _itemService;
        private readonly IMapper _mapper;


        public ItemController(IItemService itemService, IMapper mapper)
        {
            _itemService = itemService;
            _mapper = mapper;
        }

        public async Task<IActionResult> Index()
        {
            int Count = await _itemService.GetItemsCountAsync();
            ViewBag.Count = Count;
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Load(int draw, int start, int length, int count)
        {
            var data = await _itemService.GetAllItemsAsync(length, start);
            var dataModel = _mapper.Map<IEnumerable<ItemDTO>>(data);
            return Json(new { data = dataModel, draw = draw, recordsTotal = count, recordsFiltered = count });
        }

        public async Task<IActionResult> Add()
        {
            var model = new ItemDTO();
            return View(model);
        }

        [HttpPost]
        public async Task<IActionResult> Add(ItemDTO model)
        {
            if (ModelState.IsValid)
            {
                var item = _mapper.Map<Item>(model);
                int itemId = await _itemService.AddItemAsync(item);
                if (itemId != 0)
                    TempData["Success"] = "Item added successfully.";
                return RedirectToAction("Index");
            }
            TempData["Error"] = "Error while adding the Item";
            return View(model);
        }

        public async Task<IActionResult> Edit(int Id)
        {
            var item = await _itemService.GetItemByIdAsync(Id);
            var model = _mapper.Map<ItemDTO>(item);
            return View(model);
        }
        [HttpPost]
        public async Task<IActionResult> Edit(ItemDTO model)
        {
            if (ModelState.IsValid)
            {
                var item = _mapper.Map<Item>(model);
                bool updated = await _itemService.UpdateItem(item);
                if (updated)
                    TempData["Success"] = "Item updated successfully.";

                return RedirectToAction("Index");
            }
            TempData["Error"] = "Error while updating the Item";
            return View(model);
        }

        public async Task<IActionResult> Delete(int Id)
        {
            bool deleted = await _itemService.DeleteItem(Id);
            if(deleted)
                TempData["Success"] = "Item Deleted successfully.";
            else
                TempData["Error"] = "Error while deleting the Item";
            return RedirectToAction("Index");
        }
    }
}
