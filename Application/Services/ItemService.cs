using Application.Interfaces;
using Core.Entities;
using Core.Interfaces;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Services
{
    public class ItemService : IItemService
    {
        private readonly IItemRepository _itemRepository;

        public ItemService(IItemRepository itemRepository)
        {
            _itemRepository = itemRepository;
        }

        public async Task<int> AddItemAsync(Item item)
        {
            return await _itemRepository.AddItemAsync(item);
        }

        public async Task<bool> DeleteItem(int id)
        {
            return await _itemRepository.DeleteItem(id);
        }

        public async Task<IEnumerable<Item>> GetAllItemsAsync(int limit, int offset)
        {
            return await _itemRepository.GetAllItems().Skip(offset).Take(limit).ToListAsync();
        }

        public async Task<Item> GetItemByIdAsync(int id)
        {
            return await _itemRepository.GetItemByIdAsync(id);
        }

        public async Task<IEnumerable<Item>> GetItemsByNameAsync(string term)
        {
            if (string.IsNullOrWhiteSpace(term))
                return Enumerable.Empty<Item>();

            return await _itemRepository
                .GetAllItems()
                .Where(x => x.Name.ToLower().Contains(term.ToLower()))
                .Take(5)
                .ToListAsync();
        }

        public async Task<int> GetItemsCountAsync()
        {
            return await _itemRepository.GetItemsCountAsync();
        }

        public async Task<bool> UpdateItem(Item item)
        {
            return await _itemRepository.UpdateItem(item);
        }
    }
}
