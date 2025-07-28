using Core.Entities;
using Core.Interfaces;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InfraStructure.Data
{
    public class ItemRepository : IItemRepository
    {
        private readonly CubicContext _context;

        public ItemRepository(CubicContext context)
        {
            _context = context;
        }

        public async Task<int> AddItemAsync(Item item)
        {
            await _context.items.AddAsync(item);
            await _context.SaveChangesAsync();
            return item.Id;
        }

        public async Task<bool> DeleteItem(int id)
        {
            var item = await _context.items.FindAsync(id);
            if (item != null)
            {
                item.IsActive = false;
                await _context.SaveChangesAsync();
                return true;
            }
            return false;
        }

        public IQueryable<Item> GetAllItems()
        {
            return _context.items.AsQueryable();
        }

        public async Task<Item> GetItemByIdAsync(int id)
        {
            return await _context.items.FindAsync(id);
        }

        public async Task<int> GetItemsCountAsync()
        {
            return await _context.items.CountAsync();
        }

        public async Task<bool> UpdateItem(Item item)
        {
            var existingItem = await _context.items.FindAsync(item.Id);
            if (existingItem == null)
                return false;

            // Update fields
            existingItem.Name = item.Name;
            existingItem.Description = item.Description;
            existingItem.IsActive = item.IsActive;

            _context.items.Update(existingItem);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}
