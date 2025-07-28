using Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Interfaces
{
    public interface IItemRepository
    {
        Task<int> GetItemsCountAsync();
        IQueryable<Item> GetAllItems();
        Task<Item> GetItemByIdAsync(int id);
        public Task<int> AddItemAsync(Item item);
        Task<bool> UpdateItem(Item item);
        Task<bool> DeleteItem(int id);
    }
}
